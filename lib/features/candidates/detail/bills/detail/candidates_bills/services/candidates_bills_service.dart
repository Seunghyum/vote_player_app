import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:vote_player_app/features/candidates/detail/bills/bills_screen.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/candidates_bills/models/candidates_bills_response_model.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/services/candidates_service.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class CandidatesBillsService {
  Future<CandidatesBillsResponse> getCandidatesBillsById({
    required String id,
    required BillStatusEnum status,
    required String? age,
    BillTypeEnum? type = BillTypeEnum.bills,
    int page = 0,
    int pageCount = 15,
  }) async {
    try {
      String? path =
          '${dotenv.env['API_PATH']}/candidates/$id/bills?status=${status.koreanName}&type=${type == BillTypeEnum.bills ? 'bills' : 'collabills'}&page=$page&pageCount=$pageCount&age=$age';
      final url = Uri.parse(
        path,
      );
      CandidatesBillsResponse cbr = CandidatesBillsResponse(
        result: [],
        summary: CandidatesBillsSummary(total: 0, isLastPage: true),
      );

      final response = await http.get(url);
      final statusCode = response.statusCode;
      if (statusCode != 200) throw 'API응답이 비정상입니다. $statusCode';
      final data = jsonDecode(response.body);

      cbr.summary = CandidatesBillsSummary(
        total: data['summary']['total'],
        isLastPage: data['summary']['isLastPage'],
      );
      for (var bill in data['result']) {
        cbr.result.add(Bill.fromJson(bill));
      }

      return cbr;
    } catch (err) {
      logger.e(err);
      return throw '데이터를 정상적으로 불러오지 못했습니다';
    }
  }

  Future<Bill> getBillByIdWithCandidateId(
    BillTypeEnum type,
    String candidateId,
    String billId,
  ) async {
    try {
      String? path =
          '${dotenv.env['API_PATH']}/bills/$billId?type=${type == BillTypeEnum.bills ? 'bills' : 'collabills'}';
      final url = Uri.parse(
        path,
      );

      final response = await http.get(url);
      final statusCode = response.statusCode;

      if (statusCode != 200) throw 'API응답이 비정상입니다. $statusCode';
      final data = jsonDecode(response.body);

      return Bill.fromJson(data);
    } catch (err) {
      throw 'err';
    }
  }
}
