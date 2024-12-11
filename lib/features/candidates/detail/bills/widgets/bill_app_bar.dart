import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';

class BillAppBar extends AppBar {
  final Text title;
  BillAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title.toString(),
        style: const TextStyle(
          fontSize: Sizes.size20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
