// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uspltool/Models/trade_history_model.dart';
import 'package:uspltool/Provider/DashbordProvider.dart';
import 'package:uspltool/Widgets/custom_row.dart';
import 'package:uspltool/utils/color_manager.dart';

class PLReportContainer extends StatefulWidget {
  final TradeHistoryModel tradeHistoryModel;
  final double? balenceAmount;
  const PLReportContainer(
      {required this.tradeHistoryModel, this.balenceAmount, super.key});

  @override
  State<PLReportContainer> createState() => _PLReportContainerState();
}

class _PLReportContainerState extends State<PLReportContainer> {
  bool isExapned = false;
  @override
  Widget build(BuildContext context) {
    final plModel = widget.tradeHistoryModel;
    return Container(
      height: 140,
      decoration: BoxDecoration(
          color: ColorManager.balck255,
          border: const Border.symmetric(
              horizontal: BorderSide(color: Colors.black12))),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SimpleRow(
            children: [
              Text(
                (plModel.buyTime != null)
                    ? DateFormat("dd MMM,yyyy").format(plModel.buyTime!
                        .add(const Duration(hours: 5, minutes: 30)))
                    : "",
                style: const TextStyle(color: Colors.grey),
              ),
              Expanded(child: Container()),
              (plModel.sellTime == null)
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(2)),
                      child: Text(
                        'OPEN',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(2)),
                      child: Text(
                        'COMPLETE',
                        style: TextStyle(color: Colors.green.shade800),
                      ),
                    ),
            ],
          ),
          SimpleRow(
            children: [
              Row(
                children: [
                  Text(
                    plModel.instrument ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ],
              ),
              Expanded(child: Container()),
              // const CircleAvatar(
              //   radius: 5,
              //   backgroundColor: Colors.green,
              // ),
              const SizedBox(
                width: 5,
              ),
              Text("${plModel.qty} Lots")
            ],
          ),
          SimpleRow(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(2)),
                child: const Text(
                  'BUY',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      (plModel.buyTime != null)
                          ? DateFormat("HH:mm:ss").format(plModel.buyTime!
                              .add(const Duration(hours: 5, minutes: 30)))
                          : "",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Text("₹ ${(plModel.buyPrice ?? 0).toStringAsFixed(2)}"),
              Text((plModel.buyValue ?? 0).toStringAsFixed(2)),
            ],
          ),
          if ((plModel.sellTime != null))
            SimpleRow(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(2)),
                  child: const Text(
                    'SELL',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        (plModel.sellTime != null)
                            ? DateFormat("HH:mm:ss").format(plModel.sellTime!
                                .add(const Duration(hours: 5, minutes: 30)))
                            : "",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Text("₹ ${(plModel.sellPrice ?? 0).toStringAsFixed(2)}"),
                Text((plModel.sellValue ?? 0).toStringAsFixed(2)),
              ],
            ),
          SimpleRow(
            children: [
              Row(
                children: [
                  const Text(
                    "Points Gain : ",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    (plModel.pointsGain ?? 0).toStringAsFixed(2),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: ((plModel.pointsGain ?? 0).isNegative)
                            ? Colors.red
                            : Colors.green),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Gross P&L : ",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                  ),
                  Text("₹ ${(plModel.profitLoss ?? 0).toStringAsFixed(2)}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: ((plModel.profitLoss ?? 0).isNegative)
                              ? Colors.red
                              : Colors.green)),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Balence : ",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                  FittedBox(
                    child: Text("₹ ${widget.balenceAmount?.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: ((plModel.profitLoss ?? 0).isNegative)
                                ? Colors.red
                                : Colors.green)),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
/*
class PLReportContainer extends StatefulWidget {
  final TradeHistoryModel tradeHistoryModel;
  final double? balenceAmount;
  const PLReportContainer(
      {required this.tradeHistoryModel, this.balenceAmount, super.key});

  @override
  State<PLReportContainer> createState() => _PLReportContainerState();
}

class _PLReportContainerState extends State<PLReportContainer> {
  bool isExapned = false;
  @override
  Widget build(BuildContext context) {
    final plModel = widget.tradeHistoryModel;
    final dp = Provider.of<DashboardProvider>(context);

    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: ColorManager.balck255,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleRow(
            children: [
              Text(
                plModel.instrument ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
              Expanded(child: Container()),
              const CircleAvatar(
                radius: 5,
                backgroundColor: Colors.green,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                plModel.qty.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          SimpleRow(
            children: [
              Text(
                (plModel.buyTime != null)
                    ? DateFormat("dd MMM,yyy HH:mm").format(plModel.buyTime!
                        .add(const Duration(hours: 5, minutes: 30)))
                    : "",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "₹ ${(plModel.buyPrice ?? 0).toStringAsFixed(2)}",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                (plModel.buyValue ?? 0).toStringAsFixed(2),
                style: TextStyle(color: Colors.white),
              ),
              const Text(
                "BUY",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
              )
            ],
          ),
          SimpleRow(
            children: [
              Text(
                (plModel.sellTime != null)
                    ? DateFormat("dd MMM,yyy HH:mm").format(plModel.sellTime!
                        .add(const Duration(hours: 5, minutes: 30)))
                    : "",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "₹ ${(plModel.sellPrice ?? 0).toStringAsFixed(2)}",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                (plModel.sellValue ?? 0).toStringAsFixed(2),
                style: TextStyle(color: Colors.white),
              ),
              const Text(
                "SELL",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              )
            ],
          ),
          SimpleRow(
            children: [
              const Text(
                "Points Gain",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              Text((plModel.pointsGain ?? 0).toStringAsFixed(2),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ((plModel.pointsGain ?? 0).isNegative)
                          ? Colors.red
                          : Colors.green))
            ],
          ),
          SimpleRow(
            children: [
              const Text(
                "Gross P&L",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              Text("₹ ${(plModel.profitLoss ?? 0).toStringAsFixed(2)}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ((plModel.profitLoss ?? 0).isNegative)
                          ? Colors.red
                          : Colors.green))
            ],
          ),
          // if (widget.balenceAmount != null)
          SimpleRow(
            children: [
              const Text(
                "Balance Amount",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              Text("₹ ${widget.balenceAmount?.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ((widget.balenceAmount ?? 0) < 100000)
                          ? Colors.red
                          : Colors.green))
            ],
          ),
        ],
      ),
    );
  }
}
*/