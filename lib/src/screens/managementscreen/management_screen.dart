import 'package:flutter/material.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
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
            child: Text("Management"),
          ),
        ),
      ),
    );
  }
}
