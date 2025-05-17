import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:vote_player_app/features/bills/models/bill_list_model.dart';
import 'package:vote_player_app/features/candidates/services/candidates_service.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class BillListService {
  Future<BillListModelResponse> getBillList({
    required String? age,
    String? search,
    BillStatusEnum? status,
    int page = 0,
    int pageCount = 15,
  }) async {
    try {
      String? path =
          '${dotenv.env['API_PATH']}/bills?page=$page&pageCount=$pageCount&age=$age&search=$search&status=${status?.koreanName}';
      print('@@@@@ path: $path');
      final url = Uri.parse(
        path,
      );
      BillListModelResponse blr = BillListModelResponse(
        items: [],
        summary: BillListModelSummary(total: 0, isLastPage: true),
        statistics: [],
      );

      final response = await http.get(url);
      final statusCode = response.statusCode;
      if (statusCode != 200) throw 'API응답이 비정상입니다. $statusCode';
      final data = jsonDecode(response.body);

      blr.summary = BillListModelSummary(
        total: data['summary']['total'],
        isLastPage: data['summary']['isLastPage'],
      );
      for (var bill in data['items']) {
        blr.items.add(BillListModel.fromJson(bill));
      }
      for (var statistic in data['statistics']) {
        blr.statistics.add(BillListStatistics.fromJson(statistic));
      }
      return blr;
    } catch (err) {
      logger.e(err);
      return throw '데이터를 정상적으로 불러오지 못했습니다';
    }
  }
}
