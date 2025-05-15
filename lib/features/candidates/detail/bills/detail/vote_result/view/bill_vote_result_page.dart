import 'package:flutter/material.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/view/widgets/member_vote_list.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/view/widgets/search_input.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/view/widgets/vote_pie_chart.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/view/widgets/vote_type_tabs.dart';

class BillVoteResultPage extends StatelessWidget {
  // final billTitle = '청년기본법 일부개정법률안';
  // final sessionInfo = '2024.04.01 · 국회운영위원회 · 제400회';

  const BillVoteResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   billTitle,
        //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        // ),
        // Text(sessionInfo, style: const TextStyle(color: Colors.grey)),
        SizedBox(height: 20),
        Center(child: VotePieChart()),
        SizedBox(height: 10),
        VoteTypeTabs(),
        SizedBox(height: 10),
        SearchInput(),
        SizedBox(height: 10),
        SizedBox(
          height: 500,
          child: MemberVoteList(),
        ),
      ],
    );
  }
}
