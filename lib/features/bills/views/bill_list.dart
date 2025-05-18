import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/bills/bloc/bill_list_bloc.dart';
import 'package:vote_player_app/features/bills/models/bill_list_model.dart';
import 'package:vote_player_app/features/bills/views/widgets/bill_list_search_input.dart';
import 'package:vote_player_app/features/bills/views/widgets/bill_list_status_pie_chart.dart';
import 'package:vote_player_app/features/bills/views/widgets/filtered_bill_list.dart';
import 'package:vote_player_app/features/bills/views/widgets/status_filter.dart';

class BillList extends StatefulWidget {
  static String routeName = '/bills';

  const BillList({
    super.key,
  });

  @override
  State<BillList> createState() => _BillListState();
}

class _BillListState extends State<BillList> {
  final _scrollController = ScrollController();

  int filterStatus(String status) {
    final statistics = context.watch<BillListBloc>().statistics;
    final value = statistics
        .firstWhere(
          (element) => element.PROC_RESULT == status,
          orElse: () => BillListStatistics(
            count: 0,
            PROC_RESULT: status,
          ),
        )
        .count;
    return value;
  }

  void _onScroll() {
    final search = context.read<BillListBloc>().search;
    final status = context.read<BillListBloc>().selectedStatus;

    if (_isBottom) {
      context.read<BillListBloc>().add(
            BillListNextPageEvent(
              billStatus: status,
              search: search,
            ),
          );
    }
  }

  // 최하단 판별
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillListBloc, BillListState>(
      builder: (context, state) {
        final sum = state.statistics.fold(0, (a, b) => a + b.count);
        return SafeArea(
          child: Scaffold(
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverList.list(
                    children: [
                      const Center(
                        child: Text(
                          '전체 법률안 통계',
                          style: TextStyle(
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '(총 $sum개)',
                          style: const TextStyle(
                            fontSize: Sizes.size16,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      const BillListStatusPieChart(),
                      const Divider(),
                      const StatusFilter(),
                      const SizedBox(
                        height: Sizes.size12,
                      ),
                      const BillListSearchInput(),
                      const FilteredBillList(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
