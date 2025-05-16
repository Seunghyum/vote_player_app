import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/models/bill_vote_result_model.dart';
import 'package:vote_player_app/features/candidates/services/candidates_service.dart';

class BillVoteResultsService {
  Future<BillVoteResultsResponse> getBillVoteResultsByBillId(
    String billId,
    String age,
  ) async {
    try {
      String? path =
          '${dotenv.env['API_PATH']}/bills/$billId/voteResults?AGE=$age';
      final url = Uri.parse(
        path,
      );

      final response = await http.get(url);
      final statusCode = response.statusCode;
      if (statusCode != 200) throw 'API응답이 비정상입니다. $statusCode';
      final data = jsonDecode(response.body);

      BillVoteResultsResponse bvr = BillVoteResultsResponse(
        code: 404,
        items: [],
        message: null,
        statics: [],
        list_total_count: 0,
      );

      if (data == null) {
        return bvr;
      }
      if (data['code'] != null) bvr.code = data['code'];
      if (data['list_total_count'] != null)
        bvr.list_total_count = data['list_total_count'];
      if (data['items'] != null) {
        for (var voteResult in data['items']) {
          bvr.items.add(BillVoteResult.fromJson(voteResult));
        }
      }
      List<BillVoteResultsStatics> bvrStatics = [];
      for (var static in data['statics']) {
        bvrStatics.add(BillVoteResultsStatics.fromJson(static));
      }

      bvr.message = data['message'];
      bvr.statics = bvrStatics;
      return bvr;
    } catch (err) {
      logger.e(err);
      return throw '데이터를 정상적으로 불러오지 못했습니다';
    }
  }
}
