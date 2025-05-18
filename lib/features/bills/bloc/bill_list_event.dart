part of 'bill_list_bloc.dart';

abstract class BillListEvent extends Equatable {
  const BillListEvent();

  @override
  List<Object?> get props => [];
}

class FilterBillListEvent extends BillListEvent {
  final BillStatusEnum billStatus;

  const FilterBillListEvent(this.billStatus);

  @override
  List<Object?> get props => [billStatus];
}

class SearchBillListEvent extends BillListEvent {
  final String keyword;
  final BillStatusEnum status;

  const SearchBillListEvent(this.keyword, this.status);

  @override
  List<Object?> get props => [keyword];
}

class BillListNextPageEvent extends BillListEvent {
  final String search;
  final BillStatusEnum billStatus;

  const BillListNextPageEvent({
    required this.search,
    required this.billStatus,
  });
  @override
  List<Object?> get props => [];
}

class BillListFetchEvent extends BillListEvent {
  final BillStatusEnum billStatus;

  const BillListFetchEvent(this.billStatus);
  @override
  List<Object?> get props => [billStatus];
}
