import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_player_app/features/bills/bloc/bill_list_bloc.dart';
import 'package:vote_player_app/features/bills/models/bill_list_model.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_donut_chart.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class BillListStatusPieChart extends StatefulWidget {
  const BillListStatusPieChart({super.key});

  @override
  State<BillListStatusPieChart> createState() => _BillListStatusPieChartState();
}

class _BillListStatusPieChartState extends State<BillListStatusPieChart> {
  int filterStatus(String status, List<BillListStatistics> statistics) {
    return statistics
        .firstWhere(
          (element) => element.PROC_RESULT == status,
          orElse: () => BillListStatistics(
            count: 0,
            PROC_RESULT: status,
          ),
        )
        .count;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillListBloc, BillListState>(
      builder: (context, state) {
        final statistics = state.statistics;
        if (statistics.isEmpty) {
          return const CircularProgressIndicator();
        }
        return BillStatusDonutChart(
          passed: filterStatus(BillStatusEnum.passed.koreanName, statistics),
          pending: filterStatus(BillStatusEnum.pending.koreanName, statistics),
          amendmentPassed: filterStatus(
            BillStatusEnum.amendmentPassed.koreanName,
            statistics,
          ),
          alternativePassed: filterStatus(
            BillStatusEnum.alternativePassed.koreanName,
            statistics,
          ),
          termExpiration: filterStatus(
            BillStatusEnum.termExpiration.koreanName,
            statistics,
          ),
          dispose: filterStatus(BillStatusEnum.dispose.koreanName, statistics),
          withdrawal: filterStatus(
            BillStatusEnum.withdrawal.koreanName,
            statistics,
          ),
        );
      },
    );
  }
}
