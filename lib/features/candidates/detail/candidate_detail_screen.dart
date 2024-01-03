import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vote_player_app/constants/gaps.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/list_table.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/utils/url.dart';

class CandidateDetailScreen extends StatelessWidget {
  final String imagePath;
  final CandidateModel candidate;

  const CandidateDetailScreen({
    super.key,
    required this.imagePath,
    required this.candidate,
  });

  Future<void> _onLinkTap(String link) async {
    final Uri url = Uri.parse(getNormalizedUrl(link));
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  String renderEmptyString(String text) {
    return text.isNotEmpty ? text : '-';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Hero(
                  tag: candidate.id,
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(imagePath),
                  ),
                ),
              ),
              Gaps.v10,
              Text(
                candidate.koName,
                style: const TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Gaps.v10,
              ListTable(
                data: [
                  {
                    "key": '소속 위원회',
                    "value":
                        Text(renderEmptyString(candidate.affiliatedCommittee)),
                  },
                  {
                    "key": '선거구',
                    "value":
                        Text(renderEmptyString(candidate.electoralDistrict)),
                  },
                  {
                    "key": '당선횟수',
                    "value": Text(
                      renderEmptyString(candidate.electionCount),
                    ),
                  },
                  {
                    "key": '의원 홈페이지',
                    "value": GestureDetector(
                      onTap: () => _onLinkTap(candidate.memberHomepage),
                      child: Text(
                        renderEmptyString(candidate.memberHomepage),
                      ),
                    ),
                  },
                  {
                    "key": '개별 홈페이지',
                    "value": GestureDetector(
                      onTap: () => _onLinkTap(candidate.individualHomepage),
                      child: Text(
                        renderEmptyString(candidate.individualHomepage),
                      ),
                    ),
                  }
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
