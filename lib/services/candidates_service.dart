import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:vote_player_app/models/candidate_model.dart';
import 'package:vote_player_app/services/constants/service_keys.dart';

var logger = Logger();

class CandidatesService {
  late List<CandidateModel> candidates;
  late String? candidatesServiceKey = ServiceKeys.candidatesServiceKey;
  late int? pageNo = 1;
  late int? numOfRows = 15;
  late int? sgId;
  late int? sgTypecode;
  late int? cnddtId;

  CandidatesService({
    this.candidatesServiceKey,
    this.pageNo,
    this.numOfRows,
    this.sgId,
    this.sgTypecode,
    this.cnddtId,
  });

  Future<List<CandidateModel>> getCandidates({
    required int pageNo,
    required int numOfRows,
    required int sgId,
    required int sgTypecode,
    String? sggName,
    String? sdName,
  }) async {
    try {
      var path =
          'https://vote-player.s3.ap-northeast-2.amazonaws.com/candidates_data.json';
      // var path =
      //     "${dotenv.env['candidateUrlPath']}/getPoelpcddRegistSttusInfoInqire?serviceKey=$candidatesServiceKey&pageNo=$pageNo&numOfRows=$numOfRows&sgId=$sgId&sgTypecode=$sgTypecode";
      // if (sggName != null && sggName.isNotEmpty) path += "&sggName=$sggName";
      // if (sdName != null && sdName.isNotEmpty) path += "&sdName=$sdName";
      final url = Uri.parse(
        path,
      );
      List<CandidateModel> candidateInstances = [];

      final response = await http.get(url);
      final data = jsonDecode(utf8.decode(response.bodyBytes));

      for (var candidate in data) {
        candidateInstances.add(CandidateModel.fromJson(candidate));
      }

      return candidateInstances;
    } catch (err) {
      logger.e(err);
      return [];
    }
    // print('response: $response');
    // try {
    //   // http.Response data = jsonDecode(response.body);
    //   Map<String, dynamic> data = jsonDecode(response.body);

    //   // List<CandidateModel> result =
    //   //     data.map((e) => CandidateModel.fromJson(e)).toList();
    //   // candidates = result;

    //   return result;
    // } catch (err) {
    //   logger.e(err);
    //   return [];
    // }
  }
}
