import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';

class CandidateDetailScreen extends StatelessWidget {
  final String id;
  final String imagePath;
  final String name;
  final String partyName;

  const CandidateDetailScreen({
    super.key,
    required this.id,
    required this.imagePath,
    required this.name,
    required this.partyName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Hero(
              tag: id,
              child: CircleAvatar(
                foregroundImage: NetworkImage(imagePath),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
