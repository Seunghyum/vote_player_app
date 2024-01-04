import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';

class BillStatusLabel extends StatelessWidget {
  final String status;
  const BillStatusLabel({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: getColorByBillStatus(status).backgroundColor,
      child: Text(
        getColorByBillStatus(status).text ?? status,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: getColorByBillStatus(status).textColor,
          fontSize: getColorByBillStatus(status).fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

ReturnColorObject getColorByBillStatus(String status) {
  switch (status) {
    case '계류':
      return ReturnColorObject(
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );
    case '가결':
      return ReturnColorObject(
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    case '대안반영폐기':
      return ReturnColorObject(
        backgroundColor: Colors.lightGreen,
        text: '대안\n반영',
        fontSize: Sizes.size12,
        textColor: Colors.white,
      );
    case '수정안반영폐기':
      return ReturnColorObject(
        backgroundColor: Colors.green.shade400,
        text: '수정\n반영',
        fontSize: Sizes.size12,
        textColor: Colors.white,
      );
    default:
      return ReturnColorObject(
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );
  }
}

class ReturnColorObject {
  final Color backgroundColor;
  late String? text;
  late double? fontSize;
  final Color textColor;

  ReturnColorObject({
    required this.backgroundColor,
    required this.textColor,
    this.text,
    this.fontSize,
  });
}
