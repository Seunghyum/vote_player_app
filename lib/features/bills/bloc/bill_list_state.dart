part of 'bill_list_bloc.dart';

class BillListState extends Equatable {
  final BillStatusEnum selectedStatus;
  final List<BillListModel> filteredBills;
  final List<BillListStatistics> statistics;

  const BillListState({
    required this.selectedStatus,
    required this.filteredBills,
    required this.statistics,
  });

  BillListState copyWith({
    BillStatusEnum? selectedStatus,
    List<BillListModel>? filteredBills,
    List<BillListStatistics>? statistics,
  }) {
    return BillListState(
      selectedStatus: selectedStatus ?? this.selectedStatus,
      filteredBills: filteredBills ?? this.filteredBills,
      statistics: statistics ?? this.statistics,
    );
  }

  @override
  List<Object?> get props => [selectedStatus, filteredBills, statistics];
}
