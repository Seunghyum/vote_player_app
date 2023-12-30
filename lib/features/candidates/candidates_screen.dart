import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text('후보자 검색 화면')),
      body: FutureBuilder(
        future: _candidates,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: ListView.separated(
                    // scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    itemBuilder: (context, index) {
                      var candidate = snapshot.data![index];
                      return ListTile(
                        title: Text(
                          candidate.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(candidate.jdname),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 40,
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
