import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/services/candidates_service.dart';

class CandidatesScreen extends StatefulWidget {
  const CandidatesScreen({super.key});

  @override
  State<CandidatesScreen> createState() => _CandidatesScreenState();
}

class _CandidatesScreenState extends State<CandidatesScreen> {
  late Future<List<CandidateModel>> _candidates;

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
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
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
