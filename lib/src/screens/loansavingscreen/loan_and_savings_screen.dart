import 'package:flutter/material.dart';

class LoanAndSavingsScreen extends StatefulWidget {
  const LoanAndSavingsScreen({super.key});

  @override
  State<LoanAndSavingsScreen> createState() => _LoanAndSavingsScreenState();
}

class _LoanAndSavingsScreenState extends State<LoanAndSavingsScreen> {
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
              child: Text("Loans And Savings"),
            ),
          ),
        ),
      ),
    );
  }
}
