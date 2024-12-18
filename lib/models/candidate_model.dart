class Candidate {
  final String enName, koName, partyName, history, id;
  String electoralDistrict = '';
  String affiliatedCommittee = '';
  String electionCount = '';
  String officePhone = '';
  String officeRoom = '';
  String memberHomepage = '';
  String individualHomepage = '';
  String email = '';
  String aide = '';
  String chiefOfStaff = '';
  String secretary = '';
  String officeGuide = '';
  List<Bill> bills;
  List<Bill> collabills;
  List<BillsStatisticsItem> billsStatistics;
  List<BillsStatisticsItem> collabillsStatistics;
  List<BillsStatisticsItem> billsStatusStatistics;
  List<BillsStatisticsItem> collabillsStatusStatistics;

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
    required this.billsStatistics,
    required this.collabillsStatistics,
    required this.billsStatusStatistics,
    required this.collabillsStatusStatistics,
  });
  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        id: json["_id"] ?? '',
        enName: json["enName"] ?? '',
        electoralDistrict: json["electoralDistrict"] ?? '',
        affiliatedCommittee: json["affiliatedCommittee"] ?? '',
        electionCount: json["electionCount"] ?? 0,
        officePhone: json["officePhone"] ?? '',
        officeRoom: json["officeRoom"] ?? '',
        memberHomepage: json["memberHomepage"] ?? '',
        individualHomepage: json["individualHomepage"] ?? '',
        email: json["email"] ?? '',
        aide: json["aide"] ?? '',
        chiefOfStaff: json["chiefOfStaff"] ?? '',
        secretary: json["secretary"] ?? '',
        officeGuide: json["officeGuide"] ?? '',
        history: json["history"] ?? '',
        koName: json["koName"] ?? '',
        partyName: json["partyName"] ?? '',
        bills: List<Bill>.from(
          (json["bills"] ?? []).map((x) => Bill.fromJson(x)),
        ),
        collabills: List<Bill>.from(
          (json["collabills"] ?? []).map((x) => Bill.fromJson(x)),
        ),
        billsStatistics: List<BillsStatisticsItem>.from(
          (json['billsStatistics'] ?? [])
              .map((x) => BillsStatisticsItem.fromJson(x)),
        ),
        collabillsStatistics: List<BillsStatisticsItem>.from(
          (json['collabillsStatistics'] ?? [])
              .map((x) => BillsStatisticsItem.fromJson(x)),
        ),
        billsStatusStatistics: List<BillsStatisticsItem>.from(
          (json['billsStatusStatistics'] ?? [])
              .map((x) => BillsStatisticsItem.fromJson(x)),
        ),
        collabillsStatusStatistics: List<BillsStatisticsItem>.from(
          (json['collabillsStatusStatistics'] ?? [])
              .map((x) => BillsStatisticsItem.fromJson(x)),
        ),
      );
}

class Bill {
  String nth;
  String name;
  String proposers;
  String committee = '';
  DateTime date;
  String status;
  String summary;
  String billDetailUrl;
  String billNo;

  Bill({
    required this.nth,
    required this.name,
    required this.proposers,
    required this.committee,
    required this.date,
    required this.status,
    required this.summary,
    required this.billNo,
    required this.billDetailUrl,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        nth: json["nth"] ?? '',
        name: json["name"] ?? '',
        proposers: json["proposers"] ?? '',
        committee: json["committee"] ?? '',
        date: DateTime.parse(json["date"] ?? ''),
        status: json["status"] ?? '',
        summary: json["summary"] ?? '',
        billNo: json["billNo"] ?? '',
        billDetailUrl: json["billDetailUrl"] ?? '',
      );
}

class BillsStatisticsItem {
  String name;
  int value;

  BillsStatisticsItem({
    required this.name,
    required this.value,
  });

  factory BillsStatisticsItem.fromJson(Map<String, dynamic> json) =>
      BillsStatisticsItem(
        name: json["name"] ?? '',
        value: json["value"] ?? 0,
      );
}
