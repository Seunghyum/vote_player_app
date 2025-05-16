import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:vote_player_app/features/candidates/detail/bills/bills_screen.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/candidates_bills/models/candidates_bills_response_model.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/candidates_bills/services/candidates_bills_service.dart';
import 'package:vote_player_app/features/candidates/models/candidate_model.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class CandidatesBillsRepo {
  final CandidatesBillsService _service = CandidatesBillsService();

  InfiniteQuery<CandidatesBillsResponse, int> getCandidatesBillsInfiniteQuery({
    required String id,
    required BillStatusEnum status,
    required String? age,
    BillTypeEnum? type = BillTypeEnum.bills,
    int? page,
    int pageCount = 15,
  }) {
    return InfiniteQuery<CandidatesBillsResponse, int>(
      key: 'candidates-bills-$id-$status-$age',
      getNextArg: (state) {
        if (state.lastPage?.summary.isLastPage ?? false) return null;
        return state.length + 1;
      },
      queryFn: (arg) {
        return _service.getCandidatesBillsById(
          id: id,
          status: status,
          age: age,
          type: type,
          pageCount: pageCount,
          page: page ?? arg,
        );
      },
    );
  }

  Query<Bill> getBillByIdWithCandidateIdQuery({
    required BillTypeEnum type,
    required String candidateId,
    required String billNo,
  }) {
    return Query<Bill>(
      key: 'candidate-$candidateId-bill-$billNo',
      queryFn: () =>
          _service.getBillByIdWithCandidateId(type, candidateId, billNo),
    );
  }
}
