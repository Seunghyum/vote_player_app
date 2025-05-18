import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:vote_player_app/features/bills/models/bill_list_model.dart';
import 'package:vote_player_app/features/bills/services/bill_list_service.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class BillListRepo {
  final BillListService _service = BillListService();

  InfiniteQuery<BillListModelResponse, NextArg> getBillsInfiniteQuery({
    String? age = '22',
    String? search = '',
    BillStatusEnum? status,
    int? page,
    int? pageCount = 15,
  }) {
    return InfiniteQuery<BillListModelResponse, NextArg>(
      key: 'bills-list-$search-$age-${status?.englishName}-$page',
      getNextArg: (state) {
        if (state.lastPage?.summary.isLastPage ?? false) return null;
        return NextArg(
          page: state.length + 1,
          status: status ?? BillStatusEnum.all,
          search: search ?? '',
        );
      },
      queryFn: (arg) {
        return _service.getBillList(
          age: age,
          search: search ?? arg.search,
          status: status ?? arg.status,
          pageCount: pageCount ?? 15,
          page: page ?? arg.page,
        );
      },
    );
  }
}

class NextArg {
  final int page;
  final String search;
  final BillStatusEnum status;

  NextArg({
    required this.page,
    required this.status,
    required this.search,
  });
}
