// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BillStatusPieChart extends StatefulWidget {
  final int? pending;
  final int? passed;
  final int? amendmentPassed;
  final int? alternativePassed;
  const BillStatusPieChart({
    super.key,
    this.pending,
    this.passed,
    this.amendmentPassed,
    this.alternativePassed,
  });

  @override
  State<StatefulWidget> createState() => BillStatusPieChartState();
}

class BillStatusPieChartState extends State<BillStatusPieChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: showingSections(
              pending: widget.pending ?? 0,
              passed: widget.passed ?? 0,
              amendmentPassed: widget.amendmentPassed ?? 0,
              alternativePassed: widget.alternativePassed ?? 0,
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections({
    required int pending,
    required int passed,
    required int amendmentPassed,
    required int alternativePassed,
  }) {
    return List.generate(4, (i) {
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      final pending = widget.pending ?? 0;
      final passed = widget.passed ?? 0;
      final amendmentPassed = widget.amendmentPassed ?? 0;
      final alternativePassed = widget.alternativePassed ?? 0;
      final sum = pending + passed + amendmentPassed + alternativePassed;
      final pendingPer = (pending / sum * 100).round();
      final passedPer = (passed / sum * 100).round();
      final amendmentPassedPer = (amendmentPassed / sum * 100).round();
      final alternativePassedPer = (alternativePassed / sum * 100).round();

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.grey,
            value: pendingPer.toDouble(),
            title: '계류\n$pendingPer%',
            radius: 100,
            titlePositionPercentageOffset: 0.8,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
              shadows: shadows,
            ),
            showTitle: true,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: passedPer.toDouble(),
            title: '가결\n$passedPer%',
            radius: 100,
            titlePositionPercentageOffset: 0.8,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
              shadows: shadows,
            ),
            showTitle: true,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green.shade400,
            value: amendmentPassedPer.toDouble(),
            title: '수정가결\n${amendmentPassedPer.toInt()}%',
            radius: 100,
            titlePositionPercentageOffset: 0.8,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.lightGreen,
            value: alternativePassedPer.toDouble(),
            title: '대안가결\n${alternativePassedPer.toInt()}%',
            radius: 100,
            titlePositionPercentageOffset: 0.8,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
              shadows: shadows,
            ),
            showTitle: true,
          );
        default:
          throw Exception('bilsStatusPieChart err');
      }
    });
  }
}
