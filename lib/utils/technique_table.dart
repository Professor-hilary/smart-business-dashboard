import 'package:flutter/material.dart';

class TechniqueTable extends StatelessWidget {
  final List<String> columns;
  final List<List<dynamic>> rows;
  final int? paybackRow;

  const TechniqueTable({
    super.key,
    required this.columns,
    required this.rows,
    required this.paybackRow,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle titleTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Table(
        border: TableBorder.all(color: Colors.black54),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(4),
          2: FlexColumnWidth(4),
          3: FlexColumnWidth(4),
          4: FlexColumnWidth(4),
        },
        children: <TableRow>[
          TableRow(
            decoration: const BoxDecoration(color: Color(0xff002366)),
            children: columns.map((column) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(column, style: titleTextStyle),
              );
            }).toList(),
          ),
          ...rows.map(
            (row) {
              if (row.first == paybackRow) {
                return TableRow(
                  children: row.map(
                    (cell) {
                      return Container(
                        decoration: const BoxDecoration(color: Colors.green),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            cell.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
              } else {
                return TableRow(
                  children: row.map(
                    (cell) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          cell.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    },
                  ).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
