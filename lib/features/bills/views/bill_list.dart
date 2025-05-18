import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/bills/bloc/bill_list_bloc.dart';
import 'package:vote_player_app/features/bills/models/bill_list_model.dart';
import 'package:vote_player_app/features/bills/views/widgets/bill_list_search_input.dart';
import 'package:vote_player_app/features/bills/views/widgets/bill_list_status_pie_chart.dart';
import 'package:vote_player_app/features/bills/views/widgets/filtered_bill_list.dart';
import 'package:vote_player_app/features/bills/views/widgets/status_filter.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

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
  BillStatusEnum filterValue = BillStatusEnum.all;

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
    if (_isBottom) context.read<BillListBloc>().add(BillListNextPageEvent());
  }

  // 최하단 판별
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    context.read<BillListBloc>().add(BillListFetchEvent());
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverList.list(
                children: const [
                  BillListStatusPieChart(),
                  Divider(),
                  StatusFilter(),
                  SizedBox(
                    height: Sizes.size12,
                  ),
                  BillListSearchInput(),
                  FilteredBillList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
