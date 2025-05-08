import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';

class NthTab extends StatelessWidget {
  const NthTab({
    super.key,
    required this.age,
    required this.text,
  });

  final String age;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size4,
        horizontal: Sizes.size6,
      ),
      margin: const EdgeInsets.only(
        right: Sizes.size4,
        bottom: Sizes.size8,
      ),
      decoration: BoxDecoration(
        color: '$age대' == text ? Colors.blueAccent : Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(Sizes.size8),
        ),
        border: Border.all(color: Colors.grey),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: '$age대' == text ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
