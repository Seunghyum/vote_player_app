import 'package:flutter/material.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class BillStatusLabel extends StatelessWidget {
  final BillStatusEnum status;
  const BillStatusLabel({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final map = getColorByBillStatus(status);
    return CircleAvatar(
      backgroundColor: map.backgroundColor,
      child: Text(
        map.text ?? status.koreanName,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: map.textColor,
          fontSize: map.fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
