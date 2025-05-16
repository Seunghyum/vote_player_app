import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/bloc/vote_bloc.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/models/vote_type.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/view/widgets/vote_color.dart';
import 'package:vote_player_app/utils/url.dart';

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
        final imagePath = getS3ImageUrl(
          BucketCategory.candidates,
          '${member.candidate!.enName}.png',
        );
        return ListTile(
          leading: CircleAvatar(
            foregroundImage: NetworkImage(imagePath),
          ),
          title: Text(member.HG_NM),
          subtitle: Text(member.ORIG_NM!),
          trailing: Chip(
            label: Text(
              member.RESULT_VOTE_MOD,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor:
                voteColor(getVoteTypeStatus(member.RESULT_VOTE_MOD)),
          ),
        );
      },
    );
  }
}
