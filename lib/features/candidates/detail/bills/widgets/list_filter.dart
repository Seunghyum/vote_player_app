import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';

class ListFilter extends StatelessWidget {
  final Iterable<ListFilterItem> items;
  const ListFilter({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...items.map(
          (t) => GestureDetector(
            onTap: () => t.onTap(t.value),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size2,
                horizontal: Sizes.size4,
              ),
              margin: const EdgeInsets.only(right: Sizes.size4),
              // color: t.backgroundColor,
              decoration: BoxDecoration(
                // border: BoxBorder,
                color: t.backgroundColor,
                borderRadius:
                    const BorderRadius.all(Radius.circular(Sizes.size8)),
              ),
              child: Text(
                t.name,
                style: TextStyle(color: t.textColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ListFilterItem {
  String name;
  dynamic value;
  Color backgroundColor;
  Color? textColor = Colors.black;
  bool? active = false;
  void Function(dynamic value) onTap;

  ListFilterItem({
    required this.name,
    required this.value,
    required this.backgroundColor,
    this.textColor,
    this.active,
    required this.onTap,
  });
}
