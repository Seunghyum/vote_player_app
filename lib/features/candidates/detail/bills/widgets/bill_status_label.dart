import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class BillStatusLabel extends StatelessWidget {
  final BillStatusEnum status;
  const BillStatusLabel({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size2,
        horizontal: Sizes.size4,
      ),
      margin: const EdgeInsets.only(right: Sizes.size4),
      decoration: BoxDecoration(
        color: getColorByBillStatus(status).backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.size8)),
      ),
      child: Text(
        status.koreanName,
        style: TextStyle(color: getColorByBillStatus(status).textColor),
      ),
    );
  }
}
