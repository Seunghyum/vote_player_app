// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_chart_indicator.dart';

class BillStatusDonutChart extends StatefulWidget {
  final int? pending;
  final int? passed;
  final int? amendmentPassed;
  final int? alternativePassed;
  const BillStatusDonutChart({
    super.key,
    this.pending,
    this.passed,
    this.amendmentPassed,
    this.alternativePassed,
  });

  @override
  State<StatefulWidget> createState() => BillStatusDonutChartState();
}

class BillStatusDonutChartState extends State<BillStatusDonutChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Row(
        children: [
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(
                    pending: widget.pending ?? 0,
                    passed: widget.passed ?? 0,
                    amendmentPassed: widget.amendmentPassed ?? 0,
                    alternativePassed: widget.alternativePassed ?? 0,
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const BillChartIndicator(
                color: Colors.green,
                text: '가결',
                isSquare: true,
              ),
              const SizedBox(
                height: 4,
              ),
              BillChartIndicator(
                color: Colors.green.shade400,
                text: '수정반영',
                isSquare: true,
              ),
              const SizedBox(
                height: 4,
              ),
              const BillChartIndicator(
                color: Colors.lightGreen,
                text: '대안반영',
                isSquare: true,
              ),
              const SizedBox(
                height: 4,
              ),
              const BillChartIndicator(
                color: Colors.grey,
                text: '가결',
                isSquare: true,
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
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

      const titlePositionPercentageOffset = 0.6;
      const radius = 70.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.grey,
            value: pendingPer.toDouble(),
            title: '$pendingPer%',
            radius: radius,
            titlePositionPercentageOffset: titlePositionPercentageOffset,
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
            color: Colors.green.shade700,
            value: passedPer.toDouble(),
            title: '$passedPer%',
            radius: radius,
            titlePositionPercentageOffset: titlePositionPercentageOffset,
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
            color: Colors.green.shade500,
            value: amendmentPassedPer.toDouble(),
            title: '${amendmentPassedPer.toInt()}%',
            radius: radius,
            titlePositionPercentageOffset: titlePositionPercentageOffset,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green.shade300,
            value: alternativePassedPer.toDouble(),
            title: '${alternativePassedPer.toInt()}%',
            radius: radius,
            titlePositionPercentageOffset: titlePositionPercentageOffset,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
              shadows: shadows,
            ),
            showTitle: true,
          );
        default:
          throw Exception('bilsStatusDonutChart err');
      }
    });
  }
}
