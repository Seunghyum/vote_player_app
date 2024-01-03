import 'package:vote_player_app/models/candidate_model.dart';

class Model {}

// jsonObject를 Model로 치환
T toSpecificModel<T extends Model>(Map<String, dynamic> json) {
  switch (T) {
    case Candidate:
      return Candidate.fromJson(json) as T;
    default:
      throw Exception("Not Model Type");
  }
}

List<T> toSpecificModelList<T extends Model>(List list) {
  List<T> result = [];
  for (var element in list) {
    result.add(toSpecificModel(element));
  }
  return result;
}
