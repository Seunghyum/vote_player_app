import 'package:json_annotation/json_annotation.dart';

part 'bill_list_model.g.dart';

@JsonSerializable()
class BillListModel {
  @JsonKey(name: '_id')
  String? id;
  String? BILL_ID; //	의안ID
  String? BILL_NO; //	의안번호
  String? BILL_NAME; //	법률안명
  String? COMMITTEE; //	소관위원회
  String? PROPOSE_DT; //	제안일
  String? PROC_RESULT; //	본회의심의결과
  String? AGE; //	대수
  String? DETAIL_LINK; //	상세페이지
  String? PROPOSER; //	제안자
  String? MEMBER_LIST; //	제안자목록링크
  String? LAW_PROC_DT; //	법사위처리일
  String? LAW_PRESENT_DT; //	법사위상정일
  String? LAW_SUBMIT_DT; //	법사위회부일
  String? CMT_PROC_RESULT_CD; //	소관위처리결과
  String? CMT_PROC_DT; //	소관위처리일
  String? CMT_PRESENT_DT; //	소관위상정일
  String? COMMITTEE_DT; //	소관위회부일
  String? PROC_DT; //	의결일
  String? COMMITTEE_ID; //	소관위원회ID
  String? PUBL_PROPOSER; //	공동발의자
  String? LAW_PROC_RESULT_CD; //	법사위처리결과
  String? RST_PROPOSER; //	대표발의자
  String? summary;
  List<RstCandidates>? rst_candidates;

  BillListModel({
    this.id,
    this.BILL_ID,
    this.BILL_NO,
    this.BILL_NAME,
    this.COMMITTEE,
    this.PROPOSE_DT,
    this.PROC_RESULT,
    this.AGE,
    this.DETAIL_LINK,
    this.PROPOSER,
    this.MEMBER_LIST,
    this.LAW_PROC_DT,
    this.LAW_PRESENT_DT,
    this.LAW_SUBMIT_DT,
    this.CMT_PROC_RESULT_CD,
    this.CMT_PROC_DT,
    this.CMT_PRESENT_DT,
    this.COMMITTEE_DT,
    this.PROC_DT,
    this.COMMITTEE_ID,
    this.PUBL_PROPOSER,
    this.LAW_PROC_RESULT_CD,
    this.RST_PROPOSER,
    this.summary,
    this.rst_candidates,
  });

  factory BillListModel.fromJson(Map<String, dynamic> json) =>
      _$BillListModelFromJson(json);
  Map<String, dynamic> toJson() => _$BillListModelToJson(this);
}

@JsonSerializable()
class RstCandidates {
  @JsonKey(name: "_id")
  String? id;
  String? koName;
  String? enName;

  RstCandidates({
    this.id,
    this.koName,
    this.enName,
  });

  factory RstCandidates.fromJson(Map<String, dynamic> json) =>
      _$RstCandidatesFromJson(json);
  Map<String, dynamic> toJson() => _$RstCandidatesToJson(this);
}

@JsonSerializable()
class BillListModelResponse {
  List<BillListModel> items;
  BillListModelSummary summary;
  List<BillListStatistics> statistics;

  BillListModelResponse({
    required this.items,
    required this.summary,
    required this.statistics,
  });
  factory BillListModelResponse.fromJson(Map<String, dynamic> json) =>
      _$BillListModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BillListModelResponseToJson(this);
}

@JsonSerializable()
class BillListModelSummary {
  int total;
  // List<BillListStatistics> statistics;
  bool isLastPage;

  BillListModelSummary({
    required this.total,
    // required this.statistics,
    required this.isLastPage,
  });

  factory BillListModelSummary.fromJson(Map<String, dynamic> json) =>
      _$BillListModelSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$BillListModelSummaryToJson(this);
}

@JsonSerializable()
class BillListStatistics {
  String PROC_RESULT;
  int count;

  BillListStatistics({
    required this.PROC_RESULT,
    required this.count,
  });
  factory BillListStatistics.fromJson(Map<String, dynamic> json) =>
      _$BillListStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$BillListStatisticsToJson(this);
}
