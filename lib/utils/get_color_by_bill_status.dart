import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';

BillStatusEnum getBillStatus(String status) {
  if (status == BillStatusEnum.passed.koreanName) {
    return BillStatusEnum.pending;
  } else if (status == BillStatusEnum.pending.koreanName)
    return BillStatusEnum.pending;
  else if (status == BillStatusEnum.alternativePassed.koreanName)
    return BillStatusEnum.alternativePassed;
  else if (status == BillStatusEnum.amendmentPassed.koreanName)
    return BillStatusEnum.amendmentPassed;
  else if (status == BillStatusEnum.termExpiration.koreanName)
    return BillStatusEnum.termExpiration;
  else if (status == BillStatusEnum.termExpiration.koreanName)
    return BillStatusEnum.termExpiration;
  else if (status == BillStatusEnum.dispose.koreanName)
    return BillStatusEnum.dispose;
  throw 'BillStatus에 예외가 있습니다 $status';
}

enum BillStatusEnum {
  pending('계류', 'pending'),
  passed('가결', 'passed'),
  amendmentPassed('수정안반영폐기', 'amendmentPassed'),
  alternativePassed('대안반영폐기', 'alternativePassed'),
  termExpiration('임기만료폐기', 'termExpiration'),
  dispose('폐기', 'dispose');

  const BillStatusEnum(
    this.koreanName,
    this.englishName,
  );
  final String koreanName;
  final String englishName;
}

class ReturnColorObject {
  final Color backgroundColor;
  final String? text;
  late double? fontSize;
  final Color textColor;

  ReturnColorObject({
    required this.backgroundColor,
    required this.textColor,
    this.text,
    this.fontSize,
  });
}

ReturnColorObject getColorByBillStatus(status) {
  switch (status) {
    case BillStatusEnum.passed:
      return ReturnColorObject(
        backgroundColor: Colors.green.shade700,
        textColor: Colors.white,
      );
    case BillStatusEnum.alternativePassed:
      return ReturnColorObject(
        backgroundColor: Colors.green.shade300,
        text: '대안\n반영',
        fontSize: Sizes.size12,
        textColor: Colors.white,
      );
    case BillStatusEnum.amendmentPassed:
      return ReturnColorObject(
        backgroundColor: Colors.green.shade500,
        text: '수정\n반영',
        fontSize: Sizes.size12,
        textColor: Colors.white,
      );
    case BillStatusEnum.pending:
      return ReturnColorObject(
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );
    case BillStatusEnum.termExpiration:
      return ReturnColorObject(
        backgroundColor: Colors.grey.shade700,
        text: '임기\n만료',
        fontSize: Sizes.size12,
        textColor: Colors.white,
      );
    case BillStatusEnum.dispose:
      return ReturnColorObject(
        backgroundColor: Colors.grey.shade900,
        text: '폐기',
        textColor: Colors.white,
      );
    default:
      return ReturnColorObject(
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );
  }
}
