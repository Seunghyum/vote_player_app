import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/bloc/vote_bloc.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/models/vote_type.dart';

class VoteTypeTabs extends StatelessWidget {
  final voteTypes = VoteTypeEnum.values;

  const VoteTypeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedType =
        context.select((VoteBloc bloc) => bloc.state.selectedType);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: voteTypes.map((type) {
        return ChoiceChip(
          label: Text(type.koreanName),
          selected: selectedType == type,
          onSelected: (_) {
            print("@@#### type : $type");
            context.read<VoteBloc>().add(FilterVoteEvent(type));
          },
        );
      }).toList(),
    );
  }
}
