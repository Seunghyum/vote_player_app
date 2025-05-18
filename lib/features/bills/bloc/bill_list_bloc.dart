import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:vote_player_app/features/bills/models/bill_list_model.dart';
import 'package:vote_player_app/features/bills/repo/bill_list_repo.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

part 'bill_list_event.dart';
part 'bill_list_state.dart';

class BillListBloc extends Bloc<BillListEvent, BillListState> {
  final _billListRepo = BillListRepo();
  final BillStatusEnum selectedStatus;
  final List<BillListModel> filteredBills;
  final List<BillListStatistics> statistics;

  BillListBloc({
    required this.selectedStatus,
    required this.filteredBills,
    required this.statistics,
  }) : super(
          BillListState(
            selectedStatus: selectedStatus,
            filteredBills: filteredBills,
            statistics: statistics,
          ),
        ) {
    on<FilterBillListEvent>((event, emit) {
      final status = event.billStatus;
      final query = _billListRepo.getBillsInfiniteQuery(status: status);
      return emit.forEach<InfiniteQueryState<BillListModelResponse>>(
        query.stream,
        onData: (queryState) {
          return state.copyWith(
            selectedStatus: status,
            filteredBills:
                queryState.data?.expand((page) => page.items).toList() ?? [],
            statistics: queryState.data?.last.statistics ?? [],
          );
        },
      );
    });

    on<SearchBillListEvent>((event, emit) {
      final keyword = event.keyword.trim();
      final query = _billListRepo.getBillsInfiniteQuery(search: keyword);

      return emit.forEach<InfiniteQueryState<BillListModelResponse>>(
        query.stream,
        onData: (queryState) {
          return state.copyWith(
            selectedStatus: BillStatusEnum.all,
            filteredBills:
                queryState.data?.expand((page) => page.items).toList() ?? [],
            statistics: queryState.data?.last.statistics ?? [],
          );
        },
      );
    });

    on<BillListNextPageEvent>((event, emit) {
      print("!!! BillListNextPageEvent");
      _billListRepo.getBillsInfiniteQuery(status: selectedStatus).getNextPage();
    });

    on<BillListFetchEvent>((event, emit) {
      final query = _billListRepo.getBillsInfiniteQuery();

      return emit.forEach<InfiniteQueryState<BillListModelResponse>>(
        query.stream,
        onData: (queryState) {
          return state.copyWith(
            selectedStatus: BillStatusEnum.all,
            filteredBills:
                queryState.data?.expand((page) => page.items).toList() ?? [],
            statistics: queryState.data?.last.statistics ?? [],
          );
        },
      );
    });
  }
}
