import 'package:flutter/material.dart';

class TimeValueOfMoney extends StatefulWidget {
  const TimeValueOfMoney({super.key});

  @override
  State<TimeValueOfMoney> createState() => _TimeValueOfMoneyState();
}

class _TimeValueOfMoneyState extends State<TimeValueOfMoney> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.transparent,
              child: const Column(
                children: [
                  // Row(children: [Text("Compute Future Value"), ToggleButtons(children: children, isSelected: isSelected)],)
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.grey.shade900,
            thickness: 5,
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
