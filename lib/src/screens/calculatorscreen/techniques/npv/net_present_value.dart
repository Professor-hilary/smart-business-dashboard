import 'package:project/utils/technique_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:math' show pow;

class NetPresentValue extends StatefulWidget {
  const NetPresentValue({super.key});

  @override
  State<NetPresentValue> createState() => _NetPresentValueState();
}

class _NetPresentValueState extends State<NetPresentValue>
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
    int discountRate = int.tryParse(discountRateController.text) ?? 0;

    double growthRateFactor = 1 + (discountRate.toDouble() / 100);
    num interestMultiplier = pow(growthRateFactor, ++yearCounter);
    String discountingFactor = (1 / interestMultiplier).toStringAsFixed(3);

    // Calculate the cash outflow using the discounting factor
    cashOutflow = cashInflowData.toDouble() * double.parse(discountingFactor);

    // Cash inflow for 1st year is same as cash outflow for 1st year
    if (dataRows.isNotEmpty) {
      String previousCCF = dataRows.last[4].toString().replaceAll(",", "");
      cumulativeCashFlow = cashOutflow + double.parse(previousCCF);
    } else {
      cumulativeCashFlow = cashOutflow;
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
                    "Net Present Value Appraisal Technique",
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
              bool theme = Theme.of(context).brightness != Brightness.dark;
              String viability = "Investment is ";
              double capital = double.parse(initialInvestmentController.text);
              double npv = cumulativeCashFlow - capital;
              dynamic formatedNPV = npv; // For displaying computed npv
              formatedNPV = NumberFormat("#,###", "en_US").format(formatedNPV);

              viability = npv > 0 ? "Viable" : "not Viable";

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  showCloseIcon: true,
                  dismissDirection: DismissDirection.endToStart,
                  duration: const Duration(seconds: 10),
                  backgroundColor: theme ? Colors.white : Colors.black,
                  closeIconColor: Colors.red,
                  content: Text(
                    "Project is $viability because NPV is $formatedNPV",
                    style: TextStyle(
                      color: npv > 0 ? Colors.blue : Colors.red,
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
