import 'package:flutter/material.dart';
import 'package:vote_player_app/constants/sizes.dart';

class ListTable extends StatelessWidget {
  const ListTable({
    super.key,
    required this.data,
  });

  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        ...data.map((d) {
          return TableRow(
            children: <Widget>[
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.top,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Sizes.size4,
                    right: Sizes.size8,
                    bottom: Sizes.size8,
                  ),
                  child: Text(
                    d['key'],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.top,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: Sizes.size8,
                  ),
                  child: d['value'],
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
