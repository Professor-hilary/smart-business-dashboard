import 'package:flutter/material.dart';
import 'package:project/src/screens/calculatorscreen/calculator_screen.dart';
import 'package:project/src/screens/dashboard/dashboardscreen.dart';
import 'package:project/src/screens/loansavingscreen/loan_and_savings_screen.dart';
import 'package:project/src/screens/managementscreen/management_screen.dart';
import 'package:project/src/screens/memberscreen/member_screen.dart';
import 'package:project/src/screens/transactionscreen/transaction_screen.dart';
import 'package:project/src/settings/settings_view.dart';
import 'package:project/src/screens/sample_item.dart';

/// Displays a list of SampleItems.
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.items = const [
      SampleItem(1, "Home Dashboard", Icon(Icons.home)),
      SampleItem(2, "Partners Management", Icon(Icons.group)),
      SampleItem(3, "Cashflows", Icon(Icons.credit_card)),
      SampleItem(4, "Management", Icon(Icons.leaderboard)),
      SampleItem(5, "Loans & Savings", Icon(Icons.money)),
      SampleItem(6, "Capital Budgeting", Icon(Icons.calculate)),
    ],
  });

  static const routeName = '/';

  final List<SampleItem> items;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0, selectedTileIndex = 0;
  String defaultMessage = "";

  @override
  Widget build(BuildContext context) {
    switch (pageIndex) {
      case 0:
        defaultMessage = "Welcome to MicroVault Dashboard";
        break;
      case 1:
        defaultMessage = "Manage Member Details and Information";
        break;
      case 2:
        defaultMessage = "Oversee Cashflows of The Coorperation";
        break;
      case 3:
        defaultMessage = "Manage Projects and Activities of The SACCO";
        break;
      case 4:
        defaultMessage = "Keep Track of Loans Issuance and Loan Tracking";
        break;
      default:
        defaultMessage = "Perform Investment Computations and Analyses";
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff002366),
        toolbarHeight: 100,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 0,
        title: Row(
          children: [
            const Text(
              'MICROVAULT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 130),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello {user}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  defaultMessage,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          /* CircleAvatar(
            backgroundColor: Colors.black38,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white70,
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ),
          const SizedBox(width: 10), */
          CircleAvatar(
            backgroundColor: Colors.black38,
            child: IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white70,
              ),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: Row(
        children: [
          // Menu Bar
          Expanded(
            flex: 1,
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              // Providing a restorationId allows the ListView to restore the
              // scroll position when a user leaves and returns to the app after it
              // has been killed while running in the background.
              restorationId: 'sampleItemListView',
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.items[index];
                var tileColor = selectedTileIndex == index
                    ? Theme.of(context).brightness != Brightness.dark
                        ? Colors.black12
                        : Colors.white12
                    : Colors.transparent;
                return ListTile(
                    minLeadingWidth: 0,
                    minVerticalPadding: 0,
                    title: Text(item.name),
                    tileColor: tileColor,
                    leading: Container(child: item.icon),
                    onTap: () {
                      selectedTileIndex = index;
                      setState(() {
                        switch (item.id) {
                          case 1: // Dashboard
                            pageIndex = 0;
                            break;
                          case 2: // Members
                            pageIndex = 1;
                            break;
                          case 3: // Transactions
                            pageIndex = 2;
                            break;
                          case 4: // Management
                            pageIndex = 3;
                            break;
                          case 5: // Loans & Savings
                            pageIndex = 4;
                            break;
                          case 6: // Calculator
                            pageIndex = 5;
                            break;
                        }
                      });
                    });
              },
            ),
          ),

          // Main Content
          buildScreen(pageIndex),
        ],
      ),
    );
  }

  Widget buildScreen(index) {
    switch (pageIndex) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const MemberScreen();
      case 2:
        return const TransactionScreen();
      case 3:
        return const ManagementScreen();
      case 4:
        return const LoanAndSavingsScreen();
      default:
        return const CalculatorScreen();
    }
  }
}
