import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/bloc/vote_bloc.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/models/bill_vote_result_model.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/models/vote_type.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/view/widgets/vote_color.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/chart_indicator.dart';

class VotePieChart extends StatelessWidget {
  const VotePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final statics = context.watch<VoteBloc>().state.statics;
    final BillVoteResultsStatics bestStatic =
        statics.reduce((cur, next) => cur.value > next.value ? cur : next);
    int sum = statics.fold(0, (a, b) => a + b.value);

    return AspectRatio(
      aspectRatio: 1.4,
      child: Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 0.8,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      centerSpaceRadius: 50,
                      sections: [
                        ...statics.map((s) {
                          double percent = s.value / sum * 100;
                          return PieChartSectionData(
                            color: voteColor(getVoteTypeStatus(s.type)),
                            value: percent < 1 ? 1 : percent,
                            title:
                                '${percent.toStringAsFixed(1)}%\n(${s.value})',
                            titlePositionPercentageOffset: 1.3,
                          );
                        }),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 105,
                    top: 95,
                    child: Container(
                      child: Center(
                        child: Text(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size24,
                          ),
                          textAlign: TextAlign.center,
                          '${bestStatic.type}\n${(bestStatic.value / sum * 100).toStringAsFixed(0)}%',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChartIndicator(
                color: voteColor(VoteTypeEnum.approve),
                text: VoteTypeEnum.approve.koreanName,
                isSquare: true,
              ),
              ChartIndicator(
                color: voteColor(VoteTypeEnum.oppose),
                text: VoteTypeEnum.oppose.koreanName,
                isSquare: true,
              ),
              ChartIndicator(
                color: voteColor(VoteTypeEnum.abstain),
                text: VoteTypeEnum.abstain.koreanName,
                isSquare: true,
              ),
              ChartIndicator(
                color: voteColor(VoteTypeEnum.absent),
                text: VoteTypeEnum.absent.koreanName,
                isSquare: true,
              ),
            ],
          ),
          const SizedBox(
            width: Sizes.size52,
          ),
        ],
      ),
    );
  }
}
