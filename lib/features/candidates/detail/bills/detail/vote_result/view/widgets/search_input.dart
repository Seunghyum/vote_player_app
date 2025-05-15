import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_player_app/features/candidates/detail/bills/detail/vote_result/bloc/vote_bloc.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        context.read<VoteBloc>().add(SearchVoteEvent(text));
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: '의원 이름 검색',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        isDense: true,
      ),
    );
  }
}
