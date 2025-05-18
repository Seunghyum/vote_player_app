import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/features/bills/bloc/bill_list_bloc.dart';
import 'package:vote_player_app/features/candidates/detail/widgets/bill_status_label.dart';
import 'package:vote_player_app/utils/datetime.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class FilteredBillList extends StatefulWidget {
  const FilteredBillList({super.key});

  @override
  State<FilteredBillList> createState() => _FilteredBillListState();
}

class _FilteredBillListState extends State<FilteredBillList> {
  void _onListTileTap(String billNo) {
    context.push('/bills/$billNo');
  }

  @override
  void initState() {
    super.initState();

    context
        .read<BillListBloc>()
        .add(const BillListFetchEvent(BillStatusEnum.all));
  }

  @override
  Widget build(BuildContext context) {
    final bills = context.watch<BillListBloc>().state.filteredBills;

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: bills.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final bill = bills[index];
        return ListTile(
          onTap: () => _onListTileTap(bill.BILL_NO!),
          leading: BillStatusLabel(
            status: getBillStatus(bill.PROC_RESULT!),
          ),
          title: FractionallySizedBox(
            child: Text(
              bill.BILL_NAME ?? '',
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(item.COMMITTEE ?? ''),
              Row(
                children: [
                  Text(
                    "${bill.AGE}대",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    ' ${getyyyyMMdd(DateTime.parse(bill.PROPOSE_DT!))}~',
                  ),
                ],
              ),
            ],
          ),
          trailing: const Icon(
            Icons.chevron_right_sharp,
            size: Sizes.size32,
          ),
        );
      },
    );
  }
}
