import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/services/candidates_service.dart';
import 'package:vote_player_app/utils/url.dart';

class CandidateDetailScreen extends StatefulWidget {
  final String id;

  const CandidateDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<CandidateDetailScreen> createState() => _CandidateDetailScreenState();
}

class _CandidateDetailScreenState extends State<CandidateDetailScreen> {
  late Future<CandidateModel> _candidate;

  @override
  void initState() {
    _candidate = CandidatesService().getCandidateById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _candidate,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final candidate = snapshot.data;
            final imagePath = getS3ImageUrl(
              BucketCategory.candidates,
              '${candidate?.enName}.png',
            );
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Hero(
                    tag: widget.id,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade400,
                      foregroundImage: NetworkImage(
                        imagePath,
                      ),
                    ),
                  ),
                ),
              ),
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
