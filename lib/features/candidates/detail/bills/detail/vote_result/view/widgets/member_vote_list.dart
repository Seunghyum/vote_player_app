import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/bloc/vote_bloc.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/models/vote_type.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/view/widgets/vote_color.dart';

class MemberVoteList extends StatelessWidget {
  const MemberVoteList({super.key});

  @override
  Widget build(BuildContext context) {
    final members = context.watch<VoteBloc>().state.filteredMembers;

    return ListView.separated(
      itemCount: members.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final member = members[index];
        return ListTile(
          leading: CircleAvatar(child: Text(member.HG_NM[0])),
          title: Text(member.HG_NM),
          subtitle: Text(member.POLY_NM!),
          trailing: Chip(
            label: Text(
              member.RESULT_VOTE_MOD,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor:
                voteColor(getVoteTypeStatus(member.RESULT_VOTE_MOD)),
            // backgroundColor: _voteColor(VoteTypeEnum.approve),
          ),
        );
      },
    );
  }
}
