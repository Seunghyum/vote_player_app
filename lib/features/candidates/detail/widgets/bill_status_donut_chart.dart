// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/chart_indicator.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class BillStatusDonutChart extends StatefulWidget {
  final int? pending;
  final int? passed;
  final int? amendmentPassed;
  final int? alternativePassed;
  final int? termExpiration;
  final int? dispose;
  final int? withdrawal;
  final int? rejected;
  const BillStatusDonutChart({
    super.key,
    this.pending,
    this.passed,
    this.amendmentPassed,
    this.alternativePassed,
    this.termExpiration,
    this.dispose,
    this.withdrawal,
    this.rejected,
  });

  @override
  State<StatefulWidget> createState() => BillStatusDonutChartState();
}

class BillStatusDonutChartState extends State<BillStatusDonutChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 0.8,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 30,
                  sections: showingSections(
                    pending: widget.pending ?? 0,
                    passed: widget.passed ?? 0,
                    amendmentPassed: widget.amendmentPassed ?? 0,
                    alternativePassed: widget.alternativePassed ?? 0,
                    termExpiration: widget.termExpiration ?? 0,
                    dispose: widget.dispose ?? 0,
                    withdrawal: widget.withdrawal ?? 0,
                    rejected: widget.rejected ?? 0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: Sizes.size12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ChartIndicator(
                color:
                    getColorByBillStatus(BillStatusEnum.passed).backgroundColor,
                text: BillStatusEnum.passed.koreanName,
                isSquare: true,
              ),
              ChartIndicator(
                color: getColorByBillStatus(BillStatusEnum.amendmentPassed)
                    .backgroundColor,
                text: BillStatusEnum.amendmentPassed.koreanName,
                isSquare: true,
              ),
              ChartIndicator(
                color: getColorByBillStatus(BillStatusEnum.alternativePassed)
                    .backgroundColor,
                text: BillStatusEnum.alternativePassed.koreanName,
                isSquare: true,
              ),
              ChartIndicator(
                color: getColorByBillStatus(BillStatusEnum.pending)
                    .backgroundColor,
                text: BillStatusEnum.pending.koreanName,
                isSquare: true,
              ),
              ChartIndicator(
                color: getColorByBillStatus(BillStatusEnum.termExpiration)
                    .backgroundColor,
                text: BillStatusEnum.termExpiration.koreanName,
                isSquare: true,
              ),
              ChartIndicator(
                color: getColorByBillStatus(BillStatusEnum.dispose)
                    .backgroundColor,
                text: BillStatusEnum.dispose.koreanName,
                isSquare: true,
              ),
              ChartIndicator(
                color: getColorByBillStatus(BillStatusEnum.withdrawal)
                    .backgroundColor,
                text: BillStatusEnum.withdrawal.koreanName,
                isSquare: true,
              ),
              ChartIndicator(
                color: getColorByBillStatus(BillStatusEnum.rejected)
                    .backgroundColor,
                text: BillStatusEnum.rejected.koreanName,
                isSquare: true,
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
    required int withdrawal,
    required int rejected,
  }) {
    return List.generate(8, (i) {
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      final pending = widget.pending ?? 0;
      final passed = widget.passed ?? 0;
      final amendmentPassed = widget.amendmentPassed ?? 0;
      final alternativePassed = widget.alternativePassed ?? 0;
      final termExpiration = widget.termExpiration ?? 0;
      final dispose = widget.dispose ?? 0;
      final withdrawal = widget.withdrawal ?? 0;
      final rejected = widget.rejected ?? 0;
      final sum = pending +
          passed +
          amendmentPassed +
          alternativePassed +
          termExpiration +
          dispose +
          withdrawal +
          rejected;
      final pendingPer = (pending / sum * 100).round();
      final passedPer = (passed / sum * 100).round();
      final amendmentPassedPer = (amendmentPassed / sum * 100).round();
      final alternativePassedPer = (alternativePassed / sum * 100).round();
      final termExpirationPer = (termExpiration / sum * 100).round();
      final disposePer = (dispose / sum * 100).round();
      final withdrawalPer = (withdrawal / sum * 100).round();
      final rejectedPer = (rejected / sum * 100).round();

      const titlePositionPercentageOffset = 0.6;
      const radius = 70.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: getColorByBillStatus(BillStatusEnum.pending).backgroundColor,
            value: pendingPer.toDouble(),
            title: '$pendingPer%\n($pending)',
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
            title: '$passedPer%\n($passed)',
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
            title: '${amendmentPassedPer.toInt()}%\n($amendmentPassed)',
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
            title: '${alternativePassedPer.toInt()}%\n($alternativePassed)',
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
            value: termExpirationPer.toDouble(),
            title: '${termExpirationPer.toInt()}%\n($termExpiration)',
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
            value: disposePer.toDouble(),
            title: '${disposePer.toInt()}%\n($dispose)',
            radius: radius,
            titlePositionPercentageOffset: titlePositionPercentageOffset,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
              shadows: shadows,
            ),
          );
        case 6:
          return PieChartSectionData(
            color:
                getColorByBillStatus(BillStatusEnum.withdrawal).backgroundColor,
            value: withdrawalPer.toDouble(),
            title: '${withdrawalPer.toInt()}%\n($withdrawal)',
            radius: radius,
            titlePositionPercentageOffset: titlePositionPercentageOffset,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
              shadows: shadows,
            ),
          );
        case 7:
          return PieChartSectionData(
            color:
                getColorByBillStatus(BillStatusEnum.rejected).backgroundColor,
            value: rejectedPer.toDouble(),
            title: '${rejectedPer.toInt()}%\n($rejected)',
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
