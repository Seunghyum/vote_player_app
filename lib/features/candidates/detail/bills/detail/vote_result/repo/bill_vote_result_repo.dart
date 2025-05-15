import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/models/bill_vote_result_model.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/services/bills_vote_result_service.dart';

class BillVoteResultRepository {
  final _service = BillVoteResultsService();
  Query<BillVoteResultsResponse> getBillVoteResultsByBillIdQuery({
    required String billId,
    required String age,
  }) {
    return Query<BillVoteResultsResponse>(
      key: 'bill-$billId-voteResult-$age',
      queryFn: () => _service.getBillVoteResultsByBillId(billId, age),
    );
  }
}
