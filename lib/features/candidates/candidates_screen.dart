import 'package:flutter/material.dart';

class CandidatesScreen extends StatefulWidget {
  const CandidatesScreen({super.key});

  @override
  State<CandidatesScreen> createState() => _CandCatesStateScreen();
}

class _CandCatesStateScreen extends State<CandidatesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('후보자 검색 화면')),
    );
  }
}
