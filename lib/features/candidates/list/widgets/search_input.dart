import 'package:flutter/cupertino.dart';

class CandidateSearchInput extends StatefulWidget {
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? placeholder;

  const CandidateSearchInput(
      {super.key, this.onChanged, this.onSubmitted, this.placeholder});

  @override
  State<CandidateSearchInput> createState() => _CandidateSearchInputState();
}

class _CandidateSearchInputState extends State<CandidateSearchInput> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      placeholder: widget.placeholder,
      controller: _textEditingController,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
    );
  }
}
