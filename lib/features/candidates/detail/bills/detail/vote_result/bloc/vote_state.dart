part of 'vote_bloc.dart';

class VoteState extends Equatable {
  final VoteTypeEnum selectedType;
  final List<BillVoteResult> filteredMembers;
  final List<BillVoteResultsStatics> statics;

  const VoteState({
    required this.selectedType,
    required this.filteredMembers,
    required this.statics,
  });

  VoteState copyWith({
    VoteTypeEnum? selectedType,
    List<BillVoteResult>? filteredMembers,
    final List<BillVoteResultsStatics>? statics,
  }) {
    return VoteState(
      selectedType: selectedType ?? this.selectedType,
      filteredMembers: filteredMembers ?? this.filteredMembers,
      statics: statics ?? this.statics,
    );
  }

  @override
  List<Object?> get props => [selectedType, filteredMembers, statics];
}
