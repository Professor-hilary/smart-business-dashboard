import 'dart:math' show pow;
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/utils/technique_table.dart';

class PayBackPeriod extends StatefulWidget {
  const PayBackPeriod({super.key});

  @override
  State<PayBackPeriod> createState() => _PayBackPeriodState();
}

class _PayBackPeriodState extends State<PayBackPeriod> {
  // Variables to store user inputs
  final initialInvestmentController = TextEditingController();
  final yearsController = TextEditingController();
  final cashInflowController = TextEditingController();
  final discountRateController = TextEditingController();
  final salvageValueController = TextEditingController();

  // List to store cash inflows for each year dynamically
  List<List<dynamic>> dataRows = [];
  int yearCounter = 0;
  late double cashOutflow;

  // Adds a new row to the table based on user input
  void addCashInflow() {
    int cashInflowData = int.tryParse(cashInflowController.text) ?? 0;
    int discountRateData = int.tryParse(discountRateController.text) ?? 0;
    // int yearData = int.tryParse(yearsController.text) ?? 0;

    final year = dataRows.length + 1;
    final cashInflow = int.tryParse(cashInflowController.text) ?? 0;
    cashOutflow = cashInflowData.toInt() /
        pow(1 + (discountRateData.toInt() / 100), yearCounter++);

    setState(() {
      dataRows.add([
        year,
        NumberFormat("#,###", "en_US").format(cashInflow),
        NumberFormat("#,###", "en_US").format(cashOutflow),
      ]); // Add new data
      // cashInflowController.clear(); // Clear input after adding
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Material(
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9.0,
                    vertical: 18.0,
                  ),
                  child: const Text(
                    "Payback Period Appraisal Technique",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18.0,
                    horizontal: 18,
                  ),
                  child: const Text(
                    "Accumulation Schedule",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Controls
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.grey)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInputRow(
                        "Initial Investment (UGX.)",
                        initialInvestmentController,
                        "Amount",
                        "UGX. ",
                      ),
                      buildInputRow(
                        "After (YEARS)",
                        yearsController,
                        "YEARS",
                        "YRS ",
                      ),
                      buildInputRow(
                        "Discount Rate",
                        discountRateController,
                        "RATE",
                        '% ',
                        prefix: "%",
                      ),
                      buildInputRow(
                        "Salvage Value (UGX.)",
                        salvageValueController,
                        "AMOUNT",
                        "UGX. ",
                      ),
                      buildInputRow(
                        "Annual Cash Inflow (UGX.)",
                        cashInflowController,
                        "AMOUNT",
                        "UGX. ",
                        addNextYearButton: true,
                      ),

                      // Buttons for Reset and Calculate
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                // Clear fields and reset table
                                setState(() {
                                  initialInvestmentController.clear();
                                  yearsController.clear();
                                  cashInflowController.clear();
                                  discountRateController.clear();
                                  salvageValueController.clear();
                                  dataRows.clear();
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                side: const BorderSide(color: Colors.blue),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 8,
                                ),
                              ),
                              child: Text(
                                "Reset Fields",
                                style: TextStyle(
                                  color: Theme.of(context).brightness !=
                                          Brightness.dark
                                      ? Colors.blue
                                      : Colors.white,
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                // Logic for Payback Period calculation
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                side: const BorderSide(color: Colors.blue),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 8,
                                ),
                              ),
                              child: Text(
                                "Calculate PBP",
                                style: TextStyle(
                                  color: Theme.of(context).brightness !=
                                          Brightness.dark
                                      ? Colors.blue
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Table of Data
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16,
                  ),
                  child: TechniqueTable(
                    columns: const [
                      'Year',
                      'Cash Inflow',
                      'Cash Outflow',
                    ],
                    rows: dataRows,
                    paybackRow: 0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Function to build input rows dynamically
  Widget buildInputRow(
    String label,
    TextEditingController controller,
    String attribute,
    String unit, {
    bool addNextYearButton = false,
    String? prefix,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9.0),
            child: Text(label),
          ),
          const Expanded(child: SizedBox()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: attribute,
                    prefixText: prefix ?? unit,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                  ),
                ),
              ),
              if (addNextYearButton)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9.0),
                  child: SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: addCashInflow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        "Next Year",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
