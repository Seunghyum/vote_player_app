import 'package:flutter/material.dart';

class BillStatusLabel extends StatelessWidget {
  final String status;
  const BillStatusLabel({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: getColorByBillStatus(status).backgroundColor,
      child: Text(
        "계류",
        style: TextStyle(color: getColorByBillStatus(status).textColor),
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
    default:
      throw 'status 값이 설정되지 않았습니다';
  }
}

class ReturnColorObject {
  final Color backgroundColor;
  final Color textColor;

  ReturnColorObject({
    required this.backgroundColor,
    required this.textColor,
  });
}
