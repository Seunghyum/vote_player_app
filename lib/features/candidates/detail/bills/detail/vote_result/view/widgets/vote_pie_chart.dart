import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/bloc/vote_bloc.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/models/vote_type.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/view/widgets/vote_color.dart';

class VotePieChart extends StatelessWidget {
  const VotePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final statics = context.watch<VoteBloc>().state.statics;
    int sum = statics.fold(0, (a, b) => a + b.value);

    return SizedBox(
      height: 180,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 40,
          sections: [
            ...statics.map((s) {
              double percent = s.value / sum * 100;
              return PieChartSectionData(
                color: voteColor(getVoteTypeStatus(s.type)),
                value: percent < 1 ? 1 : percent,
                // title: s.type,
                title: '${percent.toStringAsFixed(1)}%\n(${s.value})',
              );
            }),
          ],
        ),
      ),
    );
  }
}
