import 'package:flutter/material.dart';
import 'package:project/src/screens/calculatorscreen/techniques/dpbp/discounted_payback_period.dart';
import 'package:project/src/screens/calculatorscreen/techniques/npv/net_present_value.dart';
import 'package:project/src/screens/calculatorscreen/techniques/pbp/payback_period.dart';
import 'package:project/src/screens/calculatorscreen/techniques/time_value_of_money/time_value_of_money.dart';
import 'package:project/utils/technique_table.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    bool darkTheme = Theme.of(context).brightness != Brightness.dark;
    return Expanded(
      flex: 4,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: darkTheme ? Colors.black12 : Colors.white12,
            ),
          ),
          color: Colors.transparent,
        ),
        child: const YourPage(),
      ),
    );
  }
}

class YourPage extends StatefulWidget {
  const YourPage({super.key});

  @override
  State<YourPage> createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7, // The number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Investment Appraisal & Time Value of Money"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              createTabTitle(text: "Time Value of Money"),
              createTabTitle(text: "Payback Period (PBP)"),
              createTabTitle(text: "Internal Rate of Return (IRR)"),
              createTabTitle(text: "Return on Investment (ROI)"),
              createTabTitle(text: "Net Present Value (NPV)"),
              createTabTitle(text: "Discounted Payback Period"),
              createTabTitle(text: "Profitability Index (PI)"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Net Present Value (NPV)
            SingleChildScrollView(
              child: TimeValueOfMoney(),
            ),

            // Payback Period (PBP)
            SingleChildScrollView(child: PayBackPeriod()),

            // Internal Rate of Return (IRR)
            SingleChildScrollView(
              child: TechniqueTable(
                columns: ['Year', 'Cash Inflow', 'Cash Outflow'],
                rows: [
                  [1, 1000, 500],
                  [2, 1200, 600],
                  [3, 1500, 700],
                ],
                paybackRow: 0,
              ),
            ),

            // Return on Investment (ROI)
            SingleChildScrollView(
              child: TechniqueTable(
                columns: ['Year', 'Cash Inflow', 'Cash Outflow'],
                rows: [
                  [1, 1000, 500],
                  [2, 1200, 600],
                  [3, 1500, 700],
                ],
                paybackRow: 0,
              ),
            ),

            // Net Present Value (NPV)
            SingleChildScrollView(child: NetPresentValue()),

            // Discounted Payback Period
            SingleChildScrollView(child: DiscountedPaybackPeriod()),

            SingleChildScrollView(
              child: TechniqueTable(
                columns: ['Year', 'Cash Inflow', 'Cash Outflow'],
                rows: [
                  [1, 1000, 500],
                  [2, 1200, 600],
                  [3, 1500, 700],
                ],
                paybackRow: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Tab createTabTitle({required String text}) => Tab(text: text);
}
