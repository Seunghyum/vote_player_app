import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_player_app/features/bills/bloc/bill_list_bloc.dart';
import 'package:easy_debounce/easy_debounce.dart';

class BillListSearchInput extends StatefulWidget {
  const BillListSearchInput({super.key});

  @override
  State<BillListSearchInput> createState() => _BillListSearchInputState();
}

class _BillListSearchInputState extends State<BillListSearchInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        EasyDebounce.debounce(
          'billListSearch', // 고유 키
          const Duration(milliseconds: 400),
          () {
            context.read<BillListBloc>().add(
                  SearchBillListEvent(
                    text,
                    context.read<BillListBloc>().selectedStatus,
                  ),
                );
          },
        );
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: '법안명 검색',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        isDense: true,
      ),
    );
  }
}
