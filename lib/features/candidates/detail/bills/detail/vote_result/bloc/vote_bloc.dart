import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/models/bill_vote_result_model.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/models/vote_type.dart';

part 'vote_event.dart';
part 'vote_state.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  final List<BillVoteResult> allMembers;
  final List<BillVoteResultsStatics> statics;

  VoteBloc({required this.allMembers, required this.statics})
      : super(
          VoteState(
            selectedType: VoteTypeEnum.all,
            filteredMembers: allMembers,
            statics: statics,
          ),
        ) {
    on<FilterVoteEvent>((event, emit) {
      final type = event.voteType;
      final filtered = type == VoteTypeEnum.all
          ? allMembers
          : allMembers
              .where(
                (m) => m.RESULT_VOTE_MOD == type.koreanName,
              )
              .toList();
      emit(state.copyWith(selectedType: type, filteredMembers: filtered));
    });

    on<SearchVoteEvent>((event, emit) {
      final keyword = event.keyword.trim();
      final baseList = state.selectedType == VoteTypeEnum.all
          ? allMembers
          : allMembers
              .where((m) => m.RESULT_VOTE_MOD == state.selectedType)
              .toList();

      final filtered =
          baseList.where((m) => m.HG_NM.contains(keyword)).toList();

      emit(state.copyWith(filteredMembers: filtered));
    });
  }
}
