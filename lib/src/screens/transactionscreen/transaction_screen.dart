import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Theme.of(context).brightness != Brightness.dark
                    ? Colors.black12
                    : Colors.white12,
              ),
            ),
            color: Colors.transparent,
          ),
          child: const SingleChildScrollView(
            child: Center(
              child: Text("Cash Flows"),
            ),
          ),
        ),
      ),
    );
  }
}
