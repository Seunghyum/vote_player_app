// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_chart_indicator.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class BillStatusDonutChart extends StatefulWidget {
  final int? pending;
  final int? passed;
  final int? amendmentPassed;
  final int? alternativePassed;
  final int? termExpiration;
  final int? dispose;
  const BillStatusDonutChart({
    super.key,
    this.pending,
    this.passed,
    this.amendmentPassed,
    this.alternativePassed,
    this.termExpiration,
    this.dispose,
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
                    termExpiration: widget.termExpiration ?? 0,
                    dispose: widget.dispose ?? 0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: Sizes.size12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BillChartIndicator(
                color:
                    getColorByBillStatus(BillStatusEnum.passed).backgroundColor,
                text: BillStatusEnum.passed.koreanName,
                isSquare: true,
              ),
              BillChartIndicator(
                color: getColorByBillStatus(BillStatusEnum.amendmentPassed)
                    .backgroundColor,
                text: BillStatusEnum.amendmentPassed.koreanName,
                isSquare: true,
              ),
              BillChartIndicator(
                color: getColorByBillStatus(BillStatusEnum.alternativePassed)
                    .backgroundColor,
                text: BillStatusEnum.alternativePassed.koreanName,
                isSquare: true,
              ),
              BillChartIndicator(
                color: getColorByBillStatus(BillStatusEnum.pending)
                    .backgroundColor,
                text: BillStatusEnum.pending.koreanName,
                isSquare: true,
              ),
              BillChartIndicator(
                color: getColorByBillStatus(BillStatusEnum.termExpiration)
                    .backgroundColor,
                text: BillStatusEnum.termExpiration.koreanName,
                isSquare: true,
              ),
              BillChartIndicator(
                color: getColorByBillStatus(BillStatusEnum.dispose)
                    .backgroundColor,
                text: BillStatusEnum.dispose.koreanName,
                isSquare: true,
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
          const SizedBox(
            width: Sizes.size4,
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
    required int termExpiration,
    required int dispose,
  }) {
    return List.generate(6, (i) {
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      final pending = widget.pending ?? 0;
      final passed = widget.passed ?? 0;
      final amendmentPassed = widget.amendmentPassed ?? 0;
      final alternativePassed = widget.alternativePassed ?? 0;
      final dispose = widget.dispose ?? 0;
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
            color: getColorByBillStatus(BillStatusEnum.pending).backgroundColor,
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
            color: getColorByBillStatus(BillStatusEnum.passed).backgroundColor,
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
            color: getColorByBillStatus(BillStatusEnum.amendmentPassed)
                .backgroundColor,
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
            color: getColorByBillStatus(BillStatusEnum.alternativePassed)
                .backgroundColor,
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
        case 4:
          return PieChartSectionData(
            color: getColorByBillStatus(BillStatusEnum.termExpiration)
                .backgroundColor,
            value: termExpiration.toDouble(),
            title: '${termExpiration.toInt()}%',
            radius: radius,
            titlePositionPercentageOffset: titlePositionPercentageOffset,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
              shadows: shadows,
            ),
          );
        case 5:
          return PieChartSectionData(
            color: getColorByBillStatus(BillStatusEnum.dispose).backgroundColor,
            value: dispose.toDouble(),
            title: '${dispose.toInt()}%',
            radius: radius,
            titlePositionPercentageOffset: titlePositionPercentageOffset,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
              shadows: shadows,
            ),
          );
        default:
          throw Exception('bilsStatusDonutChart err');
      }
    });
  }
}
