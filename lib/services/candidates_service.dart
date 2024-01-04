import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:vote_player_app/models/candidate_model.dart';

var logger = Logger();

class CandidatesService {
  late List<Candidate> candidates;
  late String? serviceKey = dotenv.env['serviceKey'];
  late int? pageNo = 1;
  late int? numOfRows = 15;
  late int? sgId;
  late int? sgTypecode;
  late int? cnddtId;

  CandidatesService({
    this.serviceKey,
    this.pageNo,
    this.numOfRows,
    this.sgId,
    this.sgTypecode,
    this.cnddtId,
  });

  Future<CandidateResponse> getCandidates({
    int currentPage = 0,
    int pageCount = 15,
    String? koName,
  }) async {
    try {
      String? path =
          '${dotenv.env['API_PATH']}/candidates?currentPage=$currentPage&pageCount=$pageCount';
      if (koName != null) path += '&koName=$koName';

      final url = Uri.parse(
        path,
      );
      CandidateResponse candidateResponse =
          CandidateResponse(result: [], summary: CandidatesSummary(count: 0));

      final response = await http.get(url);
      final statusCode = response.statusCode;
      if (statusCode != 200) throw 'API응답이 비정상입니다. $statusCode';
      final data = jsonDecode(response.body);

      candidateResponse.summary =
          CandidatesSummary(count: data['summary']['count']);

      for (var candidate in data['result']) {
        candidateResponse.result.add(Candidate.fromJson(candidate));
      }

      return candidateResponse;
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

class CandidateResponse {
  List<Candidate> result;
  CandidatesSummary summary;

  CandidateResponse({required this.result, required this.summary});
}

class CandidatesSummary {
  int count;

  CandidatesSummary({required this.count});
}
