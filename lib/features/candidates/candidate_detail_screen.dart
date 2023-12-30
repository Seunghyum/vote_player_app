import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';

class CandidateDetailScreen extends StatelessWidget {
  final int id;
  final String? imageUrl;
  const CandidateDetailScreen({
    super.key,
    required this.id,
    this.imageUrl,
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
                backgroundColor: Colors.grey.shade400,
                foregroundImage:
                    NetworkImage(imageUrl ?? 'https://picsum.photos/200/300'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
