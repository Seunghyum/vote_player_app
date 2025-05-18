import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_player_app/features/bills/bloc/bill_list_bloc.dart';

class BillListSearchInput extends StatelessWidget {
  const BillListSearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        context.read<BillListBloc>().add(SearchBillListEvent(text));
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
