import 'package:flutter/material.dart';

class DashboardCard extends StatefulWidget {
  final dynamic cardIcon;
  final String cardTitle;
  final int percentTarget;
  final MaterialColor progressColor;
  final int totalValue;
  final int growthRate;
  final String attribute;

  const DashboardCard({
    super.key,
    this.cardIcon,
    required this.cardTitle,
    required this.percentTarget,
    required this.progressColor,
    required this.totalValue,
    required this.growthRate,
    required this.attribute,
  });

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    var color = widget.growthRate > 0 ? Colors.green : Colors.red;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).brightness != Brightness.dark
                ? const Color.fromARGB(250, 250, 250, 250)
                : Colors.white12,
          ),
          height: 220,
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: widget.progressColor.withOpacity(0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(widget.cardIcon),
                        ),
                      ),
                      DropdownButton(
                        iconEnabledColor: widget.progressColor,
                        focusColor: Colors.transparent,
                        // dropdownColor: Colors.black87,
                        icon: const Icon(Icons.more_vert, size: 18),
                        underline: const SizedBox(),
                        style: Theme.of(context).textTheme.labelLarge,
                        value: _value,
                        items: const [
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              "Weekly",
                              // style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text(
                              "Monthly",
                              // style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text(
                              "Annual",
                              //style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                        onChanged: (int? value) {
                          setState(() => _value = value!);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                        widget.cardTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                // Revenue Collection
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 5,
                              decoration: BoxDecoration(
                                color: widget.progressColor.withOpacity(0.1),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                var width = constraints.maxWidth *
                                    (widget.percentTarget / 100);
                                return Container(
                                  width: width,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: widget.progressColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.attribute,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            widget.totalValue.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Text(
                        "${widget.growthRate > 0 ? "+" : "-"} %${widget.growthRate.abs()}",
                        style: TextStyle(
                          fontSize: 20,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
