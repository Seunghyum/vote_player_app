class CandidateModel {
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
  List<BillsModel> bills = [];
  CandidateModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        enName = json['enName'],
        koName = json['koName'],
        partyName = json['partyName'],
        history = json['history'],
        electoralDistrict = json['electoralDistrict'],
        affiliatedCommittee = json['affiliatedCommittee'],
        electionCount = json['electionCount'],
        officePhone = json['officePhone'],
        officeRoom = json['officeRoom'],
        memberHomepage = json['memberHomepage'],
        individualHomepage = json['individualHomepage'],
        email = json['email'],
        aide = json['aide'],
        chiefOfStaff = json['chiefOfStaff'],
        secretary = json['secretary'],
        officeGuide = json['officeGuide'],
        bills = json['bills'];
}

class BillsModel {
  String nth = '';
  String name = '';
  String proposers = '';
  String committee = '';
  String date = '';
  String status = '';
}
