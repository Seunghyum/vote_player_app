import 'package:json_annotation/json_annotation.dart';

part 'bill_vote_result_model.g.dart';

@JsonSerializable()
class BillVoteResult {
  String HG_NM; //	의원
  String? HJ_NM; //	한자명
  String? POLY_NM; //	정당
  String? ORIG_NM; //	선거구
  String? MEMBER_NO; //	의원번호
  String? POLY_CD; //	소속정당코드
  String? ORIG_CD; //	선거구코드
  String? VOTE_DATE; //	의결일자
  String? BILL_NO; //	의안번호
  String? BILL_NAME; //	의안명
  String? BILL_ID; //	의안ID
  String? LAW_TITLE; //	법률명
  String? CURR_COMMITTEE; //	소관위원회
  String RESULT_VOTE_MOD; //	표결결과
  // String? DEPT_CD; //	부서코드(사용안함)
  // String? CURR_COMMITTEE_ID; //	소관위코드
  // String? DISP_ORDER; //	표시정렬순서
  String? BILL_URL; //	의안URL
  String? BILL_NAME_URL; //	의안링크
  // String? SESSION_CD; //	회기
  // String? CURRENTS_CD; //	차수
  String? AGE; //	대
  // String? MONA_CD; //	국회의원코드
  BillVoteResultsCandidate? candidate;

  BillVoteResult({
    required this.HG_NM,
    required this.HJ_NM,
    required this.POLY_NM,
    required this.ORIG_NM,
    required this.MEMBER_NO,
    required this.POLY_CD,
    required this.ORIG_CD,
    required this.VOTE_DATE,
    required this.BILL_NO,
    required this.BILL_NAME,
    required this.BILL_ID,
    required this.LAW_TITLE,
    required this.CURR_COMMITTEE,
    required this.RESULT_VOTE_MOD,
    // required this.DEPT_CD,
    // required this.CURR_COMMITTEE_ID,
    // required this.DISP_ORDER,
    required this.BILL_URL,
    required this.BILL_NAME_URL,
    // required this.SESSION_CD,
    // required this.CURRENTS_CD,
    required this.AGE,
    // required this.MONA_CD,
    required this.candidate,
  });
  factory BillVoteResult.fromJson(Map<String, dynamic> json) =>
      _$BillVoteResultFromJson(json);
  Map<String, dynamic> toJson() => _$BillVoteResultToJson(this);
}

@JsonSerializable()
class BillVoteResultsResponse {
  List<BillVoteResult> items;
  int list_total_count;
  List<BillVoteResultsStatics> statics;
  String? message;
  int code;

  BillVoteResultsResponse({
    required this.items,
    required this.list_total_count,
    this.message,
    required this.statics,
    required this.code,
  });
  factory BillVoteResultsResponse.fromJson(Map<String, dynamic> json) =>
      _$BillVoteResultsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BillVoteResultsResponseToJson(this);
}

@JsonSerializable()
class BillVoteResultsStatics {
  String type;
  int value;
  BillVoteResultsStatics({
    required this.type,
    required this.value,
  });
  factory BillVoteResultsStatics.fromJson(Map<String, dynamic> json) =>
      _$BillVoteResultsStaticsFromJson(json);
  Map<String, dynamic> toJson() => _$BillVoteResultsStaticsToJson(this);
}

@JsonSerializable()
class BillVoteResultsCandidate {
  @JsonKey(name: "_id")
  String? id;
  String? enName;

  BillVoteResultsCandidate({
    required this.id,
    required this.enName,
  });
  factory BillVoteResultsCandidate.fromJson(Map<String, dynamic> json) =>
      _$BillVoteResultsCandidateFromJson(json);
  Map<String, dynamic> toJson() => _$BillVoteResultsCandidateToJson(this);
}
