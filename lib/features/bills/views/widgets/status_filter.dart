import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_player_app/features/bills/bloc/bill_list_bloc.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/list_filter.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class StatusFilter extends StatefulWidget {
  const StatusFilter({super.key});

  @override
  State<StatusFilter> createState() => _StatusFilterState();
}

class _StatusFilterState extends State<StatusFilter> {
  void _onFilterTap(BillStatusEnum value) {
    context.read<BillListBloc>().add(FilterBillListEvent(value));
  }

  @override
  Widget build(BuildContext context) {
    final selectedStatus = context.watch<BillListBloc>().state.selectedStatus;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ListFilter(
        items: [
          ...BillStatusEnum.values.map(
            (v) => ListFilterItem(
              name: v.koreanName,
              value: getBillStatus(v.englishName),
              backgroundColor: getColorByBillStatus(
                getBillStatus(v.englishName),
              ).backgroundColor,
              onTap: (value) {
                _onFilterTap(value);
              },
              active: selectedStatus.englishName == v.englishName,
            ),
          ),
        ],
      ),
    );
  }
}
