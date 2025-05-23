import 'package:json_annotation/json_annotation.dart';

part 'candidate_model.g.dart';

@JsonSerializable()
class Candidate {
  final String? enName;
  final String? koName;
  final String? partyName;
  final String? history;

  @JsonKey(name: '_id')
  final String? id;
  final String? electoralDistrict;
  final String? affiliatedCommittee;
  final String? electionCount;
  final String? officePhone;
  final String? officeRoom;
  final String? memberHomepage;
  final String? individualHomepage;
  final String? email;
  final String? aide;
  final String? chiefOfStaff;
  final String? secretary;
  final String? officeGuide;
  final List<Bill>? bills;
  final List<Bill>? collabills;

  final List<BillsStatisticsItem>? billsCommitteeStatistics;
  final List<BillsStatisticsItem>? collabillsCommitteeStatistics;
  final List<BillsStatisticsItem>? billsStatusStatistics;
  final List<BillsStatisticsItem>? collabillsStatusStatistics;
  final List<String>? billsNthStatistics;
  final List<String>? collabillsNthStatistics;

  Candidate({
    required this.id,
    required this.enName,
    required this.electoralDistrict,
    required this.affiliatedCommittee,
    required this.electionCount,
    required this.officePhone,
    required this.officeRoom,
    required this.memberHomepage,
    required this.individualHomepage,
    required this.email,
    required this.aide,
    required this.chiefOfStaff,
    required this.secretary,
    required this.officeGuide,
    required this.history,
    required this.koName,
    required this.partyName,
    required this.bills,
    required this.collabills,
    required this.billsCommitteeStatistics,
    required this.collabillsCommitteeStatistics,
    required this.billsStatusStatistics,
    required this.collabillsStatusStatistics,
    required this.billsNthStatistics,
    required this.collabillsNthStatistics,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);
  Map<String, dynamic> toJson() => _$CandidateToJson(this);
}

@JsonSerializable()
class Bill {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "AGE")
  String? age;
  @JsonKey(name: "BILL_ID")
  String? billId;
  @JsonKey(name: "BILL_NAME")
  String? name;
  @JsonKey(name: "PROPOSER")
  String? proposers;
  @JsonKey(name: "COMMITTEE")
  String? committee;
  @JsonKey(name: "PROPOSE_DT")
  DateTime? date;
  @JsonKey(name: "PROC_RESULT")
  String? status;
  String? summary;
  @JsonKey(name: "DETAIL_LINK")
  String? billDetailUrl;
  @JsonKey(name: "BILL_NO")
  String? billNo;

  Bill({
    required this.id,
    required this.age,
    required this.billId,
    required this.name,
    required this.proposers,
    required this.committee,
    required this.date,
    required this.status,
    required this.summary,
    required this.billNo,
    required this.billDetailUrl,
  });
  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
  Map<String, dynamic> toJson() => _$BillToJson(this);
}

@JsonSerializable()
class BillsStatisticsItem {
  String? age;
  String? name;
  int? value;

  BillsStatisticsItem({
    required this.age,
    required this.name,
    required this.value,
  });
  factory BillsStatisticsItem.fromJson(Map<String, dynamic> json) =>
      _$BillsStatisticsItemFromJson(json);
  Map<String, dynamic> toJson() => _$BillsStatisticsItemToJson(this);
}

@JsonSerializable()
class CandidatesResponse {
  List<Candidate> result;
  CandidatesSummary summary;

  CandidatesResponse({required this.result, required this.summary});
  factory CandidatesResponse.fromJson(Map<String, dynamic> json) =>
      _$CandidatesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CandidatesResponseToJson(this);
}

@JsonSerializable()
class CandidatesSummary {
  int total;
  bool isLastPage;

  CandidatesSummary({
    required this.total,
    required this.isLastPage,
  });
  factory CandidatesSummary.fromJson(Map<String, dynamic> json) =>
      _$CandidatesSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$CandidatesSummaryToJson(this);
}
