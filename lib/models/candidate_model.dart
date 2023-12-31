class CandidateModel {
  final String enName, koName, partName, history, id;
  final Map<String, dynamic> intro;

  CandidateModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        enName = json['enName'],
        koName = json['koName'],
        partName = json['partName'],
        history = json['history'],
        intro = json['intro'];
}

class IntroModel {
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
}
