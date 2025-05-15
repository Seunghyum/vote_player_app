import 'package:flutter/material.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/models/vote_type.dart';

Color voteColor(VoteTypeEnum vote) {
  switch (vote) {
    case VoteTypeEnum.approve:
      return Colors.green;
    case VoteTypeEnum.oppose:
      return Colors.red;
    case VoteTypeEnum.abstain:
      return Colors.yellow[700]!;
    case VoteTypeEnum.absent:
      return Colors.grey;
    default:
      return Colors.blueGrey;
  }
}
