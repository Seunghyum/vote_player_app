import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vote_player_app/features/bills/bloc/bill_list_bloc.dart';
import 'package:vote_player_app/features/bills/views/bill_list.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

enum BillTypeEnum { bills, collabils }

class BillListScreen extends StatefulWidget {
  static String routeName = '/bills';

  const BillListScreen({
    super.key,
  });

  @override
  State<BillListScreen> createState() => _BillListScreenState();
}

class _BillListScreenState extends State<BillListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => BillListBloc(
        selectedStatus: BillStatusEnum.all,
        filteredBills: [],
        statistics: [],
      ),
      child: const BillList(),
    );
  }
}
