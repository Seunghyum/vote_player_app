import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:vote_player_app/models/candidate_model.dart';

var logger = Logger();

class CandidatesService {
  late List<CandidateModel> candidates;
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

  Future<List<CandidateModel>> getCandidates({
    int currentPage = 0,
    int pageCount = 20,
    String? koName,
  }) async {
    try {
      String? path =
          '${dotenv.env['API_PATH']}/candidates?currentPage=$currentPage&pageCount=$pageCount';
      if (koName != null) path += '&koName=$koName';

      final url = Uri.parse(
        path,
      );
      List<CandidateModel> candidateInstances = [];

      final response = await http.get(url);
      final statusCode = response.statusCode;
      if (statusCode != 200) throw 'API응답이 비정상입니다. $statusCode';
      final data = jsonDecode(response.body);

      for (var candidate in data) {
        candidateInstances.add(CandidateModel.fromJson(candidate));
      }

      return candidateInstances;
    } catch (err) {
      logger.e(err);
      return [];
    }
  }

  Future<CandidateModel> getCandidateById(
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

      return CandidateModel.fromJson(data);
    } catch (err) {
      throw 'err';
    }
  }
}
