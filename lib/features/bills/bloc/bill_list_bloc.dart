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
  final String search;

  BillListBloc({
    required this.selectedStatus,
    required this.filteredBills,
    required this.statistics,
    required this.search,
  }) : super(
          BillListState(
            selectedStatus: selectedStatus,
            filteredBills: filteredBills,
            statistics: statistics,
            search: search,
          ),
        ) {
    on<FilterBillListEvent>((event, emit) {
      final query = _billListRepo.getBillsInfiniteQuery(
        status: event.billStatus,
        search: state.search,
      );
      return emit.forEach<InfiniteQueryState<BillListModelResponse>>(
        query.stream,
        onData: (queryState) {
          return state.copyWith(
            selectedStatus: event.billStatus,
            filteredBills:
                queryState.data?.expand((page) => page.items).toList() ?? [],
          );
        },
      );
    });

    on<SearchBillListEvent>((event, emit) {
      final keyword = event.keyword.trim();
      final query = _billListRepo.getBillsInfiniteQuery(
        search: keyword,
        status: state.selectedStatus,
      );

      return emit.forEach<InfiniteQueryState<BillListModelResponse>>(
        query.stream,
        onData: (queryState) {
          return state.copyWith(
            // selectedStatus: BillStatusEnum.all,
            filteredBills:
                queryState.data?.expand((page) => page.items).toList() ?? [],
            statistics: queryState.data?.last.statistics ?? [],
            search: keyword,
          );
        },
      );
    });

    on<BillListNextPageEvent>((event, emit) {
      _billListRepo
          .getBillsInfiniteQuery(
            search: state.search,
            status: state.selectedStatus,
          )
          .getNextPage();
    });

    on<BillListFetchEvent>((event, emit) {
      final query = _billListRepo.getBillsInfiniteQuery();
      final billStatus = event.billStatus;
      return emit.forEach<InfiniteQueryState<BillListModelResponse>>(
        query.stream,
        onData: (queryState) {
          return state.copyWith(
            selectedStatus: billStatus,
            filteredBills:
                queryState.data?.expand((page) => page.items).toList() ?? [],
            statistics: queryState.data?.last.statistics ?? [],
          );
        },
      );
    });
  }
}
