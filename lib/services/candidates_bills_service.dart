import 'dart:convert';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:vote_player_app/features/candidates/detail/bills/bills_screen.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

var logger = Logger();

class CandidatesBillsService {
  Future<CandidatesBillsResponse> getCandidatesBillsById({
    required String id,
    required BillStatusEnum status,
    BillTypeEnum? type = BillTypeEnum.bills,
    int page = 0,
    int pageCount = 15,
  }) async {
    try {
      String? path =
          '${dotenv.env['API_PATH']}/candidates/$id/bills?status=${status.koreanName}&type=${type == BillTypeEnum.bills ? 'bills' : 'collabills'}&page=$page&pageCount=$pageCount';

      print('@@@@ $path');
      final url = Uri.parse(
        path,
      );
      CandidatesBillsResponse cbr = CandidatesBillsResponse(
        result: [],
        summary:
            CandidatesBillsSummary(total: 0, isLastPage: true, allTotal: 0),
      );

      final response = await http.get(url);
      final statusCode = response.statusCode;
      if (statusCode != 200) throw 'API응답이 비정상입니다. $statusCode';
      final data = jsonDecode(response.body);

      cbr.summary = CandidatesBillsSummary(
        total: data['summary']['total'],
        isLastPage: data['summary']['isLastPage'],
        allTotal: data['summary']['allTotal'],
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

  Future<Candidate> getCandidateById(
    String id,
  ) async {
    try {
      String? path = '${dotenv.env['API_PATH']}/candidates/$id';

      final url = Uri.parse(
        path,
      );

      final response = await http.get(url);
      final statusCode = response.statusCode;

      if (statusCode != 200) throw 'API응답이 비정상입니다. $statusCode';
      final data = jsonDecode(response.body);

      return Candidate.fromJson(data);
    } catch (err) {
      throw 'err';
    }
  }
}

InfiniteQuery<CandidatesBillsResponse, int> getCandidatesBillsInfiniteQuery({
  required String id,
  required BillStatusEnum status,
  BillTypeEnum? type = BillTypeEnum.bills,
  int? page,
  int pageCount = 15,
}) {
  return InfiniteQuery<CandidatesBillsResponse, int>(
    key: 'candidates-bills-$id-$status',
    getNextArg: (state) {
      print(
          '@@@@ state.lastPage?.summary.isLastPage : ${state.lastPage?.summary.isLastPage}');
      if (state.lastPage?.summary.isLastPage ?? false) return null;
      print('@@@@ state.length + 1 : ${state.length + 1}');
      return state.length + 1;
    },
    queryFn: (arg) {
      return CandidatesBillsService().getCandidatesBillsById(
        id: id,
        status: status,
        type: type,
        pageCount: pageCount,
        page: page ?? arg,
      );
    },
  );
}

class GetCandidatesInfiniteQueryArgs {
  String id;
  BillStatusEnum status;
  BillTypeEnum type;
  int page = 0;
  int pageCount = 15;

  GetCandidatesInfiniteQueryArgs({
    required this.id,
    required this.status,
    this.type = BillTypeEnum.bills,
    required this.page,
    required this.pageCount,
  });
}

class CandidatesBillsResponse {
  List<Bill> result;
  CandidatesBillsSummary summary;

  CandidatesBillsResponse({required this.result, required this.summary});
}

class CandidatesBillsSummary {
  int total;
  bool isLastPage;
  int allTotal;

  CandidatesBillsSummary({
    required this.total,
    required this.isLastPage,
    required this.allTotal,
  });
}
