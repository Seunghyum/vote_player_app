part of 'bill_list_bloc.dart';

class BillListState extends Equatable {
  final BillStatusEnum selectedStatus;
  final List<BillListModel> filteredBills;
  final List<BillListStatistics> statistics;
  final String? search;

  const BillListState({
    required this.selectedStatus,
    required this.filteredBills,
    required this.statistics,
    this.search,
  });

  BillListState copyWith({
    BillStatusEnum? selectedStatus,
    List<BillListModel>? filteredBills,
    List<BillListStatistics>? statistics,
    String? search,
  }) {
    return BillListState(
      selectedStatus: selectedStatus ?? this.selectedStatus,
      filteredBills: filteredBills ?? this.filteredBills,
      statistics: statistics ?? this.statistics,
      search: search ?? this.search,
    );
  }

  @override
  List<Object?> get props =>
      [selectedStatus, filteredBills, statistics, search];
}
