import 'package:json_annotation/json_annotation.dart';
import 'package:vote_player_app/models/candidate_model.dart';

part 'candidates_bills_response_model.g.dart';

@JsonSerializable()
class CandidatesBillsResponse {
  List<Bill> result;
  CandidatesBillsSummary summary;

  CandidatesBillsResponse({required this.result, required this.summary});
  factory CandidatesBillsResponse.fromJson(Map<String, dynamic> json) =>
      _$CandidatesBillsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CandidatesBillsResponseToJson(this);
}

@JsonSerializable()
class CandidatesBillsSummary {
  int total;
  bool isLastPage;

  CandidatesBillsSummary({
    required this.total,
    required this.isLastPage,
  });

  factory CandidatesBillsSummary.fromJson(Map<String, dynamic> json) =>
      _$CandidatesBillsSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$CandidatesBillsSummaryToJson(this);
}
