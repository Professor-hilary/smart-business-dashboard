import 'package:project/utils/technique_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:math' show pow;

class DiscountedPaybackPeriod extends StatefulWidget {
  const DiscountedPaybackPeriod({super.key});

  @override
  State<DiscountedPaybackPeriod> createState() =>
      _DiscountedPaybackPeriodState();
}

class _DiscountedPaybackPeriodState extends State<DiscountedPaybackPeriod>
    with AutomaticKeepAliveClientMixin {
  // Controllers for user input widgets
  final initialInvestmentController = TextEditingController();
  final yearsController = TextEditingController();
  final cashInflowController = TextEditingController();
  final discountRateController = TextEditingController();
  final salvageValueController = TextEditingController();

  // List to store cash inflows for each year dynamically
  List<List<dynamic>> dataRows = <List<dynamic>>[];
  int yearCounter = 0;
  double cumulativeCashFlow = 0.0; // Use double for proper calculations
  late double cashOutflow; // Cash outflow should be a double
  late double previousCumCF; // Hold previous cumulative cash flow as double
  late int? payBackYearReached = 0;
  bool paybackSet = false;

  @override
  void initState() {
    super.initState();
    yearCounter = 0;
    cumulativeCashFlow = 0.0;
    payBackYearReached = 0;
    paybackSet = false;
  }

  // Adds a new row to the table based on user input
  Future<void> addCashInflow() async {
    int cashInflowData = int.tryParse(cashInflowController.text) ?? 0;
    int discountRateData = int.tryParse(discountRateController.text) ?? 0;

    // Calculate the discounting factor
    num pow2 = pow(1 + (discountRateData.toDouble() / 100), ++yearCounter);
    String discountingFactor = (1 / pow2).toStringAsFixed(3);

    // Calculate the cash outflow using the discounting factor
    cashOutflow = cashInflowData.toDouble() * double.parse(discountingFactor);

    // Calculate cumulative - cash flow initial year is same as cash outflow
    if (dataRows.isEmpty) {
      cumulativeCashFlow = cashOutflow;
    } else {
      // For subsequent years, add current cash outflow to previous cumulative cash flow
      previousCumCF = double.parse(
        dataRows.last[4].toString().replaceAll(",", ""),
      );
      cumulativeCashFlow = cashOutflow + previousCumCF;

      var parse = double.parse(initialInvestmentController.text);
      if (cumulativeCashFlow >= parse && !paybackSet) {
        payBackYearReached = yearCounter;
        paybackSet = true;
      }
    }

    // Format the values before adding them to the table
    final int year = dataRows.length + 1;

    setState(() {
      // Add new row with all calculated data
      dataRows.add([
        year, // Year
        NumberFormat("#,###", "en_US").format(cashInflowData), // Cash inflow
        discountingFactor, // Discounting factor
        NumberFormat("#,###", "en_US").format(cashOutflow),
        NumberFormat("#,###", "en_US").format(cumulativeCashFlow),
      ]);

      // Optionally clear input fields if needed
      // cashInflowController.clear();
      // discountRateController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Material(
            color: const Color(0xff002366).withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9.0,
                    vertical: 18.0,
                  ),
                  child: const Text(
                    "Discounted Payback Period Appraisal Technique",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18.0,
                    horizontal: 18,
                  ),
                  child: const Text(
                    "Accumulation Schedule",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        payBackYearReached,
                        false,
                        null,
                      ),
                      buildInputRow(
                        "After (YEARS)",
                        yearsController,
                        "YEARS",
                        "YRS ",
                        payBackYearReached,
                        false,
                        null,
                      ),
                      buildInputRow(
                        "Discount Rate",
                        discountRateController,
                        "RATE",
                        '% ',
                        payBackYearReached,
                        false,
                        "%",
                      ),
                      buildInputRow(
                        "Salvage Value (UGX.)",
                        salvageValueController,
                        "AMOUNT",
                        "UGX. ",
                        payBackYearReached,
                        false,
                        null,
                      ),
                      buildInputRow(
                        "Annual Cash Inflow (UGX.)",
                        cashInflowController,
                        "AMOUNT",
                        "UGX. ",
                        payBackYearReached,
                        true,
                        null,
                      ),

                      // Buttons for Reset and Calculate
                      buttonControls(context),
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
                    paybackRow: payBackYearReached,
                    columns: const [
                      'Year',
                      'Cash Inflow',
                      "Discounting Factor",
                      'Present Value',
                      'Cumulative CashInflow'
                    ],
                    rows: dataRows,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding buttonControls(BuildContext context) {
    bool brightness2 = Theme.of(context).brightness != Brightness.dark;
    return Padding(
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

                yearCounter = 0;
                payBackYearReached = 0;
                cumulativeCashFlow = 0.0;
                paybackSet = false;
              });
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              side: const BorderSide(color: Color(0xff002366)),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 8,
              ),
            ),
            child: Text(
              "Reset Fields",
              style: TextStyle(
                color: Theme.of(context).brightness != Brightness.dark
                    ? const Color(0xff002366)
                    : Colors.white,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              int? pbp = payBackYearReached;
              bool theme = Theme.of(context).brightness != Brightness.dark;
              bool viabilityState = pbp! <= int.parse(yearsController.text);
              String viability;

              if (viabilityState == true) {
                viability = "Investment is Viable";
              } else {
                viability = "Investment is not Viable";
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  showCloseIcon: true,
                  dismissDirection: DismissDirection.endToStart,
                  duration: const Duration(seconds: 10),
                  backgroundColor: theme ? Colors.white : Colors.black,
                  closeIconColor: Colors.red,
                  content: Text(
                    "Payback Period Is Year $pbp hence $viability",
                    style: TextStyle(
                      color:
                          viabilityState ? const Color(0xff002366) : Colors.red,
                    ),
                  ),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              side: const BorderSide(color: Color(0xff002366)),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 8,
              ),
            ),
            child: Text(
              "Accertain Investment",
              style: TextStyle(
                color: brightness2 ? const Color(0xff002366) : Colors.white,
              ),
            ),
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
    String unit,
    int? payBackYearReached,
    bool addNextYearButton,
    String? prefix,
  ) {
    // bool readonlyState = dataRows.isNotEmpty && addNextYearButton;

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
                  // readOnly: readonlyState ? false : true,
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
                        backgroundColor: const Color(0xff002366),
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

  @override
  bool get wantKeepAlive => true;
}
