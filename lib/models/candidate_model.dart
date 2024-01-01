class CandidateModel {
  final String enName, koName, partyName, history, id;
  Map<String, String> intro = {
    'electoralDistrict': '',
    'affiliatedCommittee': '',
    'electionCount': '',
    'officePhone': '',
    'officeRoom': '',
    'memberHomepage': '',
    'individualHomepage': '',
    'email': '',
    'aide': '',
    'chiefOfStaff': '',
    'secretary': '',
    'officeGuide': '',
  };
  CandidateModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        enName = json['enName'],
        koName = json['koName'],
        partyName = json['partyName'],
        history = json['history'],
        intro = {
          'electoralDistrict': json['intro']['electoralDistrict'],
          'affiliatedCommittee': json['intro']['affiliatedCommittee'],
          'electionCount': json['intro']['electionCount'],
          'officePhone': json['intro']['officePhone'],
          'officeRoom': json['intro']['officeRoom'],
          'memberHomepage': json['intro']['memberHomepage'],
          'individualHomepage': json['intro']['individualHomepage'],
          'email': json['intro']['email'],
          'aide': json['intro']['aide'],
          'chiefOfStaff': json['intro']['chiefOfStaff'],
          'secretary': json['intro']['secretary'],
          'officeGuide': json['intro']['officeGuide'],
        };
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
