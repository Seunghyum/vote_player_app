// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillListModel _$BillListModelFromJson(Map<String, dynamic> json) =>
    BillListModel(
      id: json['_id'] as String?,
      BILL_ID: json['BILL_ID'] as String?,
      BILL_NO: json['BILL_NO'] as String?,
      BILL_NAME: json['BILL_NAME'] as String?,
      COMMITTEE: json['COMMITTEE'] as String?,
      PROPOSE_DT: json['PROPOSE_DT'] as String?,
      PROC_RESULT: json['PROC_RESULT'] as String?,
      AGE: json['AGE'] as String?,
      DETAIL_LINK: json['DETAIL_LINK'] as String?,
      PROPOSER: json['PROPOSER'] as String?,
      MEMBER_LIST: json['MEMBER_LIST'] as String?,
      LAW_PROC_DT: json['LAW_PROC_DT'] as String?,
      LAW_PRESENT_DT: json['LAW_PRESENT_DT'] as String?,
      LAW_SUBMIT_DT: json['LAW_SUBMIT_DT'] as String?,
      CMT_PROC_RESULT_CD: json['CMT_PROC_RESULT_CD'] as String?,
      CMT_PROC_DT: json['CMT_PROC_DT'] as String?,
      CMT_PRESENT_DT: json['CMT_PRESENT_DT'] as String?,
      COMMITTEE_DT: json['COMMITTEE_DT'] as String?,
      PROC_DT: json['PROC_DT'] as String?,
      COMMITTEE_ID: json['COMMITTEE_ID'] as String?,
      PUBL_PROPOSER: json['PUBL_PROPOSER'] as String?,
      LAW_PROC_RESULT_CD: json['LAW_PROC_RESULT_CD'] as String?,
      RST_PROPOSER: json['RST_PROPOSER'] as String?,
      summary: json['summary'] as String?,
      rst_candidates: (json['rst_candidates'] as List<dynamic>?)
          ?.map((e) => RstCandidates.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BillListModelToJson(BillListModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'BILL_ID': instance.BILL_ID,
      'BILL_NO': instance.BILL_NO,
      'BILL_NAME': instance.BILL_NAME,
      'COMMITTEE': instance.COMMITTEE,
      'PROPOSE_DT': instance.PROPOSE_DT,
      'PROC_RESULT': instance.PROC_RESULT,
      'AGE': instance.AGE,
      'DETAIL_LINK': instance.DETAIL_LINK,
      'PROPOSER': instance.PROPOSER,
      'MEMBER_LIST': instance.MEMBER_LIST,
      'LAW_PROC_DT': instance.LAW_PROC_DT,
      'LAW_PRESENT_DT': instance.LAW_PRESENT_DT,
      'LAW_SUBMIT_DT': instance.LAW_SUBMIT_DT,
      'CMT_PROC_RESULT_CD': instance.CMT_PROC_RESULT_CD,
      'CMT_PROC_DT': instance.CMT_PROC_DT,
      'CMT_PRESENT_DT': instance.CMT_PRESENT_DT,
      'COMMITTEE_DT': instance.COMMITTEE_DT,
      'PROC_DT': instance.PROC_DT,
      'COMMITTEE_ID': instance.COMMITTEE_ID,
      'PUBL_PROPOSER': instance.PUBL_PROPOSER,
      'LAW_PROC_RESULT_CD': instance.LAW_PROC_RESULT_CD,
      'RST_PROPOSER': instance.RST_PROPOSER,
      'summary': instance.summary,
      'rst_candidates': instance.rst_candidates,
    };

RstCandidates _$RstCandidatesFromJson(Map<String, dynamic> json) =>
    RstCandidates(
      id: json['_id'] as String?,
      koName: json['koName'] as String?,
      enName: json['enName'] as String?,
    );

Map<String, dynamic> _$RstCandidatesToJson(RstCandidates instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'koName': instance.koName,
      'enName': instance.enName,
    };

BillListModelResponse _$BillListModelResponseFromJson(
        Map<String, dynamic> json) =>
    BillListModelResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => BillListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: BillListModelSummary.fromJson(
          json['summary'] as Map<String, dynamic>),
      statistics: (json['statistics'] as List<dynamic>)
          .map((e) => BillListStatistics.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BillListModelResponseToJson(
        BillListModelResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'summary': instance.summary,
      'statistics': instance.statistics,
    };

BillListModelSummary _$BillListModelSummaryFromJson(
        Map<String, dynamic> json) =>
    BillListModelSummary(
      total: (json['total'] as num).toInt(),
      isLastPage: json['isLastPage'] as bool,
    );

Map<String, dynamic> _$BillListModelSummaryToJson(
        BillListModelSummary instance) =>
    <String, dynamic>{
      'total': instance.total,
      'isLastPage': instance.isLastPage,
    };

BillListStatistics _$BillListStatisticsFromJson(Map<String, dynamic> json) =>
    BillListStatistics(
      PROC_RESULT: json['PROC_RESULT'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$BillListStatisticsToJson(BillListStatistics instance) =>
    <String, dynamic>{
      'PROC_RESULT': instance.PROC_RESULT,
      'count': instance.count,
    };
