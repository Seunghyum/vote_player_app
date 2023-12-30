import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/candidate_detail_screen.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/services/candidates_service.dart';

class CandidatesScreen extends StatefulWidget {
  const CandidatesScreen({super.key});

  @override
  State<CandidatesScreen> createState() => _CandidatesScreenState();
}

class _CandidatesScreenState extends State<CandidatesScreen> {
  late Future<List<CandidateModel>> _candidates;

  void _onListTileTap({required int id, String? imageUrl}) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) {
          return CandidateDetailScreen(
            id: id,
            imageUrl: imageUrl,
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
    _candidates = CandidatesService().getCandidates(
      pageNo: 1,
      numOfRows: 15,
      sgId: 20240410,
      sgTypecode: 2,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('후보자 화면'),
          ),
          FutureBuilder(
            future: _candidates,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SliverList.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    var candidate = snapshot.data![index];
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size10),
                      child: ListTile(
                        onTap: () => _onListTileTap(
                          id: candidate.id,
                          // imageUrl: null,
                        ),
                        leading: Hero(
                          tag: candidate.id,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade400,
                            foregroundImage: const NetworkImage(
                              'https://picsum.photos/200/300',
                            ),
                          ),
                        ),
                        title: Text(
                          candidate.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(candidate.jdname),
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
    );
  }
}
