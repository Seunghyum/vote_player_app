// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_vote_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillVoteResult _$BillVoteResultFromJson(Map<String, dynamic> json) =>
    BillVoteResult(
      HG_NM: json['HG_NM'] as String,
      HJ_NM: json['HJ_NM'] as String?,
      POLY_NM: json['POLY_NM'] as String?,
      ORIG_NM: json['ORIG_NM'] as String?,
      MEMBER_NO: json['MEMBER_NO'] as String?,
      POLY_CD: json['POLY_CD'] as String?,
      ORIG_CD: json['ORIG_CD'] as String?,
      VOTE_DATE: json['VOTE_DATE'] as String?,
      BILL_NO: json['BILL_NO'] as String?,
      BILL_NAME: json['BILL_NAME'] as String?,
      BILL_ID: json['BILL_ID'] as String?,
      LAW_TITLE: json['LAW_TITLE'] as String?,
      CURR_COMMITTEE: json['CURR_COMMITTEE'] as String?,
      RESULT_VOTE_MOD: json['RESULT_VOTE_MOD'] as String,
      BILL_URL: json['BILL_URL'] as String?,
      BILL_NAME_URL: json['BILL_NAME_URL'] as String?,
      AGE: json['AGE'] as String?,
      candidate: json['candidate'] == null
          ? null
          : BillVoteResultsCandidate.fromJson(
              json['candidate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BillVoteResultToJson(BillVoteResult instance) =>
    <String, dynamic>{
      'HG_NM': instance.HG_NM,
      'HJ_NM': instance.HJ_NM,
      'POLY_NM': instance.POLY_NM,
      'ORIG_NM': instance.ORIG_NM,
      'MEMBER_NO': instance.MEMBER_NO,
      'POLY_CD': instance.POLY_CD,
      'ORIG_CD': instance.ORIG_CD,
      'VOTE_DATE': instance.VOTE_DATE,
      'BILL_NO': instance.BILL_NO,
      'BILL_NAME': instance.BILL_NAME,
      'BILL_ID': instance.BILL_ID,
      'LAW_TITLE': instance.LAW_TITLE,
      'CURR_COMMITTEE': instance.CURR_COMMITTEE,
      'RESULT_VOTE_MOD': instance.RESULT_VOTE_MOD,
      'BILL_URL': instance.BILL_URL,
      'BILL_NAME_URL': instance.BILL_NAME_URL,
      'AGE': instance.AGE,
      'candidate': instance.candidate,
    };

BillVoteResultsResponse _$BillVoteResultsResponseFromJson(
        Map<String, dynamic> json) =>
    BillVoteResultsResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => BillVoteResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      list_total_count: (json['list_total_count'] as num).toInt(),
      message: json['message'] as String?,
      statics: (json['statics'] as List<dynamic>)
          .map(
              (e) => BillVoteResultsStatics.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$BillVoteResultsResponseToJson(
        BillVoteResultsResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'list_total_count': instance.list_total_count,
      'statics': instance.statics,
      'message': instance.message,
      'code': instance.code,
    };

BillVoteResultsStatics _$BillVoteResultsStaticsFromJson(
        Map<String, dynamic> json) =>
    BillVoteResultsStatics(
      type: json['type'] as String,
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$BillVoteResultsStaticsToJson(
        BillVoteResultsStatics instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };

BillVoteResultsCandidate _$BillVoteResultsCandidateFromJson(
        Map<String, dynamic> json) =>
    BillVoteResultsCandidate(
      id: json['_id'] as String?,
      enName: json['enName'] as String?,
    );

Map<String, dynamic> _$BillVoteResultsCandidateToJson(
        BillVoteResultsCandidate instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'enName': instance.enName,
    };
