part of 'vote_bloc.dart';

abstract class VoteEvent extends Equatable {
  const VoteEvent();

  @override
  List<Object?> get props => [];
}

class FilterVoteEvent extends VoteEvent {
  final VoteTypeEnum voteType;

  const FilterVoteEvent(this.voteType);

  @override
  List<Object?> get props => [voteType];
}

class SearchVoteEvent extends VoteEvent {
  final String keyword;

  const SearchVoteEvent(this.keyword);

  @override
  List<Object?> get props => [keyword];
}
