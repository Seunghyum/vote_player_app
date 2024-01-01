import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/candidate_detail_screen.dart';

import 'package:vote_player_app/features/candidates/widgets/search_input.dart';
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
  late Future<List<CandidateModel>> _candidates;

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

  @override
  void initState() {
    _candidates = CandidatesService().getCandidates();
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
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              elevation: 1,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.size10),
                child: CandidateSearchInput(),
              ),
            ),
            FutureBuilder(
              future: _candidates,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SliverList.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final candidate = snapshot.data![index];
                      final imagePath = getS3ImageUrl(
                        BucketCategory.candidates,
                        '${candidate.enName}.png',
                      );
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size10,
                        ),
                        child: ListTile(
                          onTap: () => _onListTileTap(
                            id: candidate.id,
                            imagePath: imagePath,
                            name: candidate.koName,
                            partyName: candidate.partyName,
                          ),
                          leading: Hero(
                            tag: candidate.id,
                            child: CircleAvatar(
                              foregroundImage: NetworkImage(imagePath),
                            ),
                          ),
                          title: Text(
                            candidate.koName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            candidate.partyName,
                          ),
                          trailing: const Icon(
                            Icons.chevron_right_sharp,
                            size: Sizes.size32,
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
