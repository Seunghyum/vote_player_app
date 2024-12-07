import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';
import 'package:vote_player_app/utils/get_color_by_bill_status.dart';

class ListFilter extends StatelessWidget {
  final Iterable<ListFilterItem> items;
  const ListFilter({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...items.map(
        (t) => GestureDetector(
          onTap: () => t.onTap(t.value),
          child: Opacity(
            opacity: t.active == true ? 1 : 0.7,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size2,
                horizontal: Sizes.size4,
              ),
              margin: const EdgeInsets.only(right: Sizes.size4),
              decoration: BoxDecoration(
                color: t.backgroundColor,
                borderRadius:
                    const BorderRadius.all(Radius.circular(Sizes.size8)),
                border: t.active == true
                    ? Border.all(color: Theme.of(context).primaryColor)
                    : null,
              ),
              child: Text(
                t.name,
                style: TextStyle(color: t.textColor),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class ListFilterItem {
  String name;
  BillStatusEnum value;
  Color backgroundColor;
  Color? textColor = Colors.black;
  bool? active = false;
  void Function(BillStatusEnum value) onTap;

  ListFilterItem({
    required this.name,
    required this.value,
    required this.backgroundColor,
    this.textColor,
    this.active,
    required this.onTap,
  });
}
