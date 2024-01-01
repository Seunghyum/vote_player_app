import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/detail/candidate_detail_screen.dart';

import 'package:vote_player_app/features/candidates/list/widgets/search_input.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/services/candidates_service.dart';
import 'package:vote_player_app/utils/keyboard.dart';
import 'package:vote_player_app/utils/url.dart';

class CandidatesScreen extends StatefulWidget {
  const CandidatesScreen({super.key});

  @override
  State<CandidatesScreen> createState() => _CandidatesScreenState();
}

class _CandidatesScreenState extends State<CandidatesScreen> {
  final pageSize = 20;

  final PagingController<int, CandidateModel> _pagingController =
      PagingController(firstPageKey: 0);

  void _onListTileTap({
    required String id,
    required String imagePath,
    required String name,
    required String partyName,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) {
          return CandidateDetailScreen(
            id: id,
            imagePath: imagePath,
            name: name,
            partyName: partyName,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await CandidatesService().getCandidates(pageKey, pageSize);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        body: RefreshIndicator(
          edgeOffset: 110,
          onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                elevation: 1,
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.size10),
                  child: CandidateSearchInput(),
                ),
              ),
              PagedSliverList<int, CandidateModel>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<CandidateModel>(
                  itemBuilder: (context, item, index) {
                    final imagePath = getS3ImageUrl(
                      BucketCategory.candidates,
                      '${item.enName}.png',
                    );
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size10,
                      ),
                      child: ListTile(
                        onTap: () => _onListTileTap(
                          id: item.id,
                          imagePath: imagePath,
                          name: item.koName,
                          partyName: item.partyName,
                        ),
                        leading: Hero(
                          tag: item.id,
                          child: CircleAvatar(
                            foregroundImage: NetworkImage(imagePath),
                          ),
                        ),
                        title: Text(
                          item.koName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          item.partyName,
                        ),
                        trailing: const Icon(
                          Icons.chevron_right_sharp,
                          size: Sizes.size32,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
