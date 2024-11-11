import 'package:flutter/material.dart';
import 'package:project/src/screens/dashboard/components/dashboard_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: SingleChildScrollView(
        child: Container(
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
          height: MediaQuery.sizeOf(context).height,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.0, top: 12),
                child: Text(
                  "Overview",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              // Four Cards
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    DashboardCard(
                      cardIcon: Icons.credit_score,
                      cardTitle: "Revenue Collection Against Target",
                      percentTarget: 74,
                      progressColor: Colors.red,
                      totalValue: 1330244,
                      growthRate: 23,
                      attribute: "Amount",
                    ),
                    DashboardCard(
                      cardIcon: Icons.person,
                      cardTitle: "New Member Growth Rate",
                      percentTarget: 14,
                      progressColor: Colors.teal,
                      totalValue: 34,
                      growthRate: 4,
                      attribute: 'New Members',
                    ),
                    DashboardCard(
                      cardIcon: Icons.work_history,
                      cardTitle: "Project Achievement Rate",
                      percentTarget: 38,
                      progressColor: Colors.blue,
                      totalValue: 34,
                      growthRate: -53,
                      attribute: 'Complete Projects',
                    ),
                    DashboardCard(
                      cardIcon: Icons.credit_score,
                      cardTitle: "Periodical Meetings And Events",
                      percentTarget: 85,
                      progressColor: Colors.yellow,
                      totalValue: 134,
                      growthRate: 90,
                      attribute: 'Total Meetings',
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 12.0, top: 12),
                child: Text(
                  "Project Accomplishments",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
