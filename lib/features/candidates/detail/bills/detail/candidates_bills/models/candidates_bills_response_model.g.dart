// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidates_bills_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CandidatesBillsResponse _$CandidatesBillsResponseFromJson(
        Map<String, dynamic> json) =>
    CandidatesBillsResponse(
      result: (json['result'] as List<dynamic>)
          .map((e) => Bill.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: CandidatesBillsSummary.fromJson(
          json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CandidatesBillsResponseToJson(
        CandidatesBillsResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'summary': instance.summary,
    };

CandidatesBillsSummary _$CandidatesBillsSummaryFromJson(
        Map<String, dynamic> json) =>
    CandidatesBillsSummary(
      total: (json['total'] as num).toInt(),
      isLastPage: json['isLastPage'] as bool,
    );

Map<String, dynamic> _$CandidatesBillsSummaryToJson(
        CandidatesBillsSummary instance) =>
    <String, dynamic>{
      'total': instance.total,
      'isLastPage': instance.isLastPage,
    };
