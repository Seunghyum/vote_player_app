// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(
      id: json['_id'] as String?,
      enName: json['enName'] as String?,
      electoralDistrict: json['electoralDistrict'] as String?,
      affiliatedCommittee: json['affiliatedCommittee'] as String?,
      electionCount: json['electionCount'] as String?,
      officePhone: json['officePhone'] as String?,
      officeRoom: json['officeRoom'] as String?,
      memberHomepage: json['memberHomepage'] as String?,
      individualHomepage: json['individualHomepage'] as String?,
      email: json['email'] as String?,
      aide: json['aide'] as String?,
      chiefOfStaff: json['chiefOfStaff'] as String?,
      secretary: json['secretary'] as String?,
      officeGuide: json['officeGuide'] as String?,
      history: json['history'] as String?,
      koName: json['koName'] as String?,
      partyName: json['partyName'] as String?,
      bills: (json['bills'] as List<dynamic>?)
          ?.map((e) => Bill.fromJson(e as Map<String, dynamic>))
          .toList(),
      collabills: (json['collabills'] as List<dynamic>?)
          ?.map((e) => Bill.fromJson(e as Map<String, dynamic>))
          .toList(),
      billsCommitteeStatistics: (json['billsCommitteeStatistics']
              as List<dynamic>?)
          ?.map((e) => BillsStatisticsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      collabillsCommitteeStatistics: (json['collabillsCommitteeStatistics']
              as List<dynamic>?)
          ?.map((e) => BillsStatisticsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      billsStatusStatistics: (json['billsStatusStatistics'] as List<dynamic>?)
          ?.map((e) => BillsStatisticsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      collabillsStatusStatistics: (json['collabillsStatusStatistics']
              as List<dynamic>?)
          ?.map((e) => BillsStatisticsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      billsNthStatistics: (json['billsNthStatistics'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      collabillsNthStatistics:
          (json['collabillsNthStatistics'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$CandidateToJson(Candidate instance) => <String, dynamic>{
      'enName': instance.enName,
      'koName': instance.koName,
      'partyName': instance.partyName,
      'history': instance.history,
      '_id': instance.id,
      'electoralDistrict': instance.electoralDistrict,
      'affiliatedCommittee': instance.affiliatedCommittee,
      'electionCount': instance.electionCount,
      'officePhone': instance.officePhone,
      'officeRoom': instance.officeRoom,
      'memberHomepage': instance.memberHomepage,
      'individualHomepage': instance.individualHomepage,
      'email': instance.email,
      'aide': instance.aide,
      'chiefOfStaff': instance.chiefOfStaff,
      'secretary': instance.secretary,
      'officeGuide': instance.officeGuide,
      'bills': instance.bills,
      'collabills': instance.collabills,
      'billsCommitteeStatistics': instance.billsCommitteeStatistics,
      'collabillsCommitteeStatistics': instance.collabillsCommitteeStatistics,
      'billsStatusStatistics': instance.billsStatusStatistics,
      'collabillsStatusStatistics': instance.collabillsStatusStatistics,
      'billsNthStatistics': instance.billsNthStatistics,
      'collabillsNthStatistics': instance.collabillsNthStatistics,
    };

Bill _$BillFromJson(Map<String, dynamic> json) => Bill(
      id: json['_id'] as String?,
      age: json['AGE'] as String?,
      name: json['BILL_NAME'] as String?,
      proposers: json['PROPOSER'] as String?,
      committee: json['COMMITTEE'] as String?,
      date: json['PROPOSE_DT'] == null
          ? null
          : DateTime.parse(json['PROPOSE_DT'] as String),
      status: json['PROC_RESULT'] as String?,
      summary: json['COMMITTEE_ID'] as String?,
      billNo: json['BILL_NO'] as String?,
      billDetailUrl: json['DETAIL_LINK'] as String?,
    );

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
      '_id': instance.id,
      'AGE': instance.age,
      'BILL_NAME': instance.name,
      'PROPOSER': instance.proposers,
      'COMMITTEE': instance.committee,
      'PROPOSE_DT': instance.date?.toIso8601String(),
      'PROC_RESULT': instance.status,
      'COMMITTEE_ID': instance.summary,
      'DETAIL_LINK': instance.billDetailUrl,
      'BILL_NO': instance.billNo,
    };

BillsStatisticsItem _$BillsStatisticsItemFromJson(Map<String, dynamic> json) =>
    BillsStatisticsItem(
      age: json['age'] as String?,
      name: json['name'] as String?,
      value: (json['value'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BillsStatisticsItemToJson(
        BillsStatisticsItem instance) =>
    <String, dynamic>{
      'age': instance.age,
      'name': instance.name,
      'value': instance.value,
    };
