import 'dart:convert';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:vote_player_app/features/candidates/models/candidate_model.dart';

var logger = Logger();

class CandidatesService {
  Future<CandidatesResponse> getCandidates({
    int page = 0,
    int pageCount = 15,
    String? koName,
  }) async {
    try {
      String? path =
          '${dotenv.env['API_PATH']}/candidates?page=$page&pageCount=$pageCount';
      if (koName != null) path += '&koName=$koName';

      final url = Uri.parse(
        path,
      );
      CandidatesResponse cr = CandidatesResponse(
        result: [],
        summary: CandidatesSummary(total: 0, isLastPage: true),
      );

      final response = await http.get(url);
      final statusCode = response.statusCode;
      if (statusCode != 200) throw 'API응답이 비정상입니다. $statusCode';
      final data = jsonDecode(response.body);

      cr.summary = CandidatesSummary(
        total: data['summary']['total'],
        isLastPage: data['summary']['isLastPage'],
      );
      for (var candidate in data['result']) {
        cr.result.add(Candidate.fromJson(candidate));
      }

      return cr;
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
