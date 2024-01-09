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
  });
  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        id: json["_id"],
        enName: json["enName"],
        electoralDistrict: json["electoralDistrict"],
        affiliatedCommittee: json["affiliatedCommittee"],
        electionCount: json["electionCount"],
        officePhone: json["officePhone"],
        officeRoom: json["officeRoom"],
        memberHomepage: json["memberHomepage"],
        individualHomepage: json["individualHomepage"],
        email: json["email"],
        aide: json["aide"],
        chiefOfStaff: json["chiefOfStaff"],
        secretary: json["secretary"],
        officeGuide: json["officeGuide"],
        history: json["history"],
        koName: json["koName"],
        partyName: json["partyName"],
        bills: List<Bill>.from(
          json["bills"].map((x) => Bill.fromJson(x)),
        ),
      );
}

class Bill {
  String nth;
  String name;
  String proposers;
  String committee;
  DateTime date;
  String status;

  Bill({
    required this.nth,
    required this.name,
    required this.proposers,
    required this.committee,
    required this.date,
    required this.status,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        nth: json["nth"] ?? '',
        name: json["name"] ?? '',
        proposers: json["proposers"] ?? '',
        committee: json["committee"] ?? '',
        date: DateTime.parse(json["date"] ?? ''),
        status: json["status"] ?? '',
      );
}
