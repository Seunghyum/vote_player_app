import 'package:flutter/material.dart';
import 'package:vote_player_app/features/candidates/detail/bills/widgets/bill_app_bar.dart';

class BillDetailScreen extends StatelessWidget {
  final String title;
  final String summary;
  final String url;
  const BillDetailScreen(
      {super.key,
      required this.title,
      required this.summary,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BillAppBar(
        title: Text(title),
      ),
      body: Text(summary),
    );
  }
}
