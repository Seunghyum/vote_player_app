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

  const SearchBillListEvent(this.keyword);

  @override
  List<Object?> get props => [keyword];
}

class BillListNextPageEvent extends BillListEvent {
  @override
  List<Object?> get props => [];
}

class BillListFetchEvent extends BillListEvent {
  @override
  List<Object?> get props => [];
}
