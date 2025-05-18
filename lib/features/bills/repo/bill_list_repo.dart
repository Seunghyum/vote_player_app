import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:vote_player_app/features/bills/models/bill_list_model.dart';
import 'package:vote_player_app/features/bills/services/bill_list_service.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class BillListRepo {
  final BillListService _service = BillListService();

  InfiniteQuery<BillListModelResponse, int> getBillsInfiniteQuery({
    String? age = '22',
    String? search = '',
    BillStatusEnum? status = BillStatusEnum.all,
    int? page,
    int? pageCount = 15,
  }) {
    return InfiniteQuery<BillListModelResponse, int>(
      key: 'bills-list-$search-$age-${status?.koreanName}',
      getNextArg: (state) {
        if (state.lastPage?.summary.isLastPage ?? false) return null;
        return state.length + 1;
      },
      queryFn: (arg) {
        return _service.getBillList(
          age: age,
          search: search,
          status: status,
          pageCount: pageCount ?? 15,
          page: page ?? arg,
        );
      },
    );
  }
}
