import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/candidate_detail_screen.dart';
import 'package:vote_player_app/features/candidates/widgets/search_input.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/services/candidates_service.dart';
import 'package:vote_player_app/utils/url.dart';

class CandidatesScreen extends StatefulWidget {
  const CandidatesScreen({super.key});

  @override
  State<CandidatesScreen> createState() => _CandidatesScreenState();
}

class _CandidatesScreenState extends State<CandidatesScreen> {
  late Future<List<CandidateModel>> _candidates;

  void _onListTileTap({required String id, String? imageUrl}) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) {
          return CandidateDetailScreen(
            id: id,
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

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
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
                          ),
                          leading: Hero(
                            tag: candidate.id,
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50),
                                ), //here
                                color: Colors.grey.shade400,
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade400,
                                foregroundImage: NetworkImage(imagePath),
                              ),
                            ),
                          ),
                          title: Text(
                            candidate.koName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            candidate.partName,
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
