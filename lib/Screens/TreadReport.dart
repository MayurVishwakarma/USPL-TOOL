// ignore_for_file: avoid_unnecessary_containers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uspltool/Provider/TradeBookProvider.dart';
import 'package:uspltool/Widgets/TreadingReportWidget.dart';
import 'package:uspltool/Widgets/custom_textfield.dart';
import 'package:uspltool/Widgets/empty.dart';
import 'package:uspltool/Widgets/history_container.dart';
import 'package:uspltool/Widgets/utils.dart';
import 'package:uspltool/utils/color_manager.dart';

class TradeReportScreen extends StatefulWidget {
  const TradeReportScreen({super.key});

  @override
  State<TradeReportScreen> createState() => _TradeReportScreenState();
}

class _TradeReportScreenState extends State<TradeReportScreen> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  int noOfDays = 1;

  @override
  void initState() {
    final tdp = Provider.of<TradeBookProvider>(context, listen: false);
    fromDateController.text = tdp.getFirstDateString();
    toDateController.text = tdp.getTodayDateString();
    tdp.updateDate(from: tdp.getFirstDate(), to: DateTime.now());
    tdp.updateBalnce(100000);
    noOfDays = countSelectedDates();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => tdp.getTradeHistoryModelList(context));
    super.initState();
  }

  int countSelectedDates() {
    final tdp = Provider.of<TradeBookProvider>(context, listen: false);
    var res = tdp.fromDate
        ?.difference(tdp.toDate!.add(const Duration(days: 1)))
        .inDays
        .abs();
    return res!.toInt();
  }

  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final tdp = Provider.of<TradeBookProvider>(context);
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: SizedBox(
                        height: 35,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        tdp.updateSelectedSecrionType(
                                            'BANKNIFTY');
                                        tdp.getTradeHistoryList(context);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: tdp.selectedSection ==
                                                    'BANKNIFTY'
                                                ? Colors.deepOrange
                                                : null,
                                            border: tdp.selectedSection !=
                                                    'BANKNIFTY'
                                                ? Border.all(
                                                    color: Colors.white)
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'BANKNIFTY',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        tdp.updateSelectedSecrionType('NIFTY');
                                        tdp.getNifty50TradeHistoryList(context);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                tdp.selectedSection == 'NIFTY'
                                                    ? Colors.deepOrange
                                                    : null,
                                            border:
                                                tdp.selectedSection != 'NIFTY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'NIFTY',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        tdp.updateSelectedSecrionType(
                                            'NIFTY-FIN');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: tdp.selectedSection ==
                                                    'NIFTY-FIN'
                                                ? Colors.deepOrange
                                                : null,
                                            border: tdp.selectedSection !=
                                                    'NIFTY-FIN'
                                                ? Border.all(
                                                    color: Colors.white)
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'NIFTY-FIN',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        tdp.updateSelectedSecrionType(
                                            'MID-CAP');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: tdp.selectedSection ==
                                                    'MID-CAP'
                                                ? Colors.deepOrange
                                                : null,
                                            border:
                                                tdp.selectedSection != 'MID-CAP'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'MID-CAP',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        tdp.updateSelectedSecrionType('STOCK');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                tdp.selectedSection == 'STOCK'
                                                    ? Colors.deepOrange
                                                    : null,
                                            border:
                                                tdp.selectedSection != 'STOCK'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'STOCK OPTIONS',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        tdp.updateSelectedSecrionType('EQUITY');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                tdp.selectedSection == 'EQUITY'
                                                    ? Colors.deepOrange
                                                    : null,
                                            border:
                                                tdp.selectedSection != 'EQUITY'
                                                    ? Border.all(
                                                        color: Colors.white)
                                                    : null,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'EQUITY',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: _getReportWidget(tdp.selectedSection))
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _getReportWidget(String? res) {
    final tdp = Provider.of<TradeBookProvider>(context);
    switch (res) {
      case 'BANKNIFTY':
        return Container(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                          nameController: fromDateController,
                          name: "From Date",
                          readOnly: true,
                          onTap: () async {
                            final result = await tdp.showCustomDatePicker(
                                context,
                                isFirstDate: true); //isFirstDate: true
                            if (result != null) {
                              toDateController.text =
                                  DateFormat('dd-MM-yyyy').format(tdp.toDate!);
                              fromDateController.text = result;
                            }
                          },
                        )),
                        Expanded(
                          child: CustomTextField(
                            nameController: toDateController,
                            name: "To Date",
                            readOnly: true,
                            onTap: () async {
                              final result =
                                  await tdp.showCustomDatePicker(context);
                              if (result != null) {
                                toDateController.text = result;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (fromDateController.text.isNotEmpty &&
                              toDateController.text.isNotEmpty) {
                            noOfDays = countSelectedDates();
                            tdp.updateBalnce(100000);
                            tdp.getTradeHistoryModelList(context);
                          } else {
                            Utils.showSnackBar(
                                context: context,
                                content: "Please select Date");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        child: const Text("Search")),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.deepOrange,
                        value: 'fixmargin',
                        groupValue: tdp.selectedRType,
                        onChanged: (value) {
                          tdp.updateSelectedRType(value);
                        },
                      ),
                      const Text(
                        'Fixed Margin',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.deepOrange,
                        value: 'fixlot',
                        groupValue: tdp.selectedRType,
                        onChanged: (value) {
                          tdp.updateSelectedRType(value);
                        },
                      ),
                      const Text(
                        'Fixed Lot',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.deepOrange,
                        value: 'cumilative',
                        groupValue: tdp.selectedRType,
                        onChanged: (value) {
                          tdp.updateSelectedRType(value);
                        },
                      ),
                      const Text(
                        'Cumilative',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
              if (tdp.tradeHistoryModelList.isEmpty) const EmptyWidget(),
              if (tdp.isLoading)
                const Expanded(
                    child: Center(child: CircularProgressIndicator())),
              if (!tdp.isLoading)
                Expanded(
                  child: ScrollbarTheme(
                    data: ScrollbarThemeData(
                      thumbColor: MaterialStateProperty.all(
                          Colors.deepOrange), // Set the color you desire
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _firstController,
                      thickness: 10,
                      trackVisibility: true,
                      interactive: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _firstController,
                        itemCount: tdp.tradeHistoryModelList.length,
                        itemBuilder: (context, index) {
                          return PLReportContainer(
                            tradeHistoryModel: tdp.tradeHistoryModelList[index],
                            balenceAmount: tdp
                                .getRemainingAmount(
                                    tdp.tradeHistoryModelList, index)
                                .toDouble(),
                          ); //PLReportContainer(tradeHistoryModel:tdp.tradeHistoryModelList[index],);
                        },
                      ),
                    ),
                  ),
                ),
              Divider(),
              TradingReport(
                isExpanded: tdp.isExpanded,
                tradeList: tdp.tradeHistoryModelList,
                balence: tdp.getTotalPL().toDouble(),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                // margin: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    color: ColorManager.balck255,
                    borderRadius: BorderRadius.circular(12)),
                child: /*Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Flexible(
                                      child: Text(
                                        "Total P&L",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "₹ ${tdp.getTotalPL().toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: (tdp.getTotalPL().isNegative)
                                              ? Colors.red
                                              : Colors.green),
                                    ),
                                    const Flexible(
                                      child: Text(
                                        "Total Points",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                        tdp
                                            .getTotalPointsGains()
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: (tdp
                                                    .getTotalPointsGains()
                                                    .isNegative)
                                                ? Colors.red
                                                : Colors.green))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Flexible(
                                      child: Text(
                                        "Avg Points Per Day",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                        tdp
                                            .getAvgPointsPerDay()
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: (tdp
                                                    .getAvgPointsPerDay()
                                                    .isNegative)
                                                ? Colors.red
                                                : Colors.green))
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  tdp.updateIsExpaned(!tdp.isExpanded);
                                },
                                icon: !tdp.isExpanded
                                    ? Transform.rotate(
                                        angle: pi / 2,
                                        child: const Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.deepOrange,
                                        ))
                                    : Transform.rotate(
                                        angle: 3 * pi / 2,
                                        child: const Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.deepOrange,
                                        ))),
                          )
                        ],
                      ),
                      */
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Total P&L : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        Text(
                          "${tdp.getTotalPL().toStringAsFixed(2)} ₹",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: (tdp.getTotalPL().isNegative)
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Total Points : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                            Text(
                              tdp.getTotalPointsGain().toStringAsFixed(2),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: (tdp.getTotalPointsGain().isNegative)
                                      ? Colors.red
                                      : Colors.green),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Avg point per day : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                  color: Colors.white),
                            ),
                            Text(
                              (tdp.getTotalPointsGain() / noOfDays)
                                  .toStringAsFixed(2),
                              style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: ((tdp.getTotalPointsGain() / noOfDays)
                                          .isNegative)
                                      ? Colors.red
                                      : Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          tdp.updateIsExpaned(!tdp.isExpanded);
                        },
                        icon: !tdp.isExpanded
                            ? Transform.rotate(
                                angle: pi / 2,
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.deepOrange,
                                ))
                            : Transform.rotate(
                                angle: 3 * pi / 2,
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.deepOrange,
                                )))
                  ],
                ),
              ),
            ],
          ),
        );
      case 'NIFTY':
        return Container(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                          nameController: fromDateController,
                          name: "From Date",
                          readOnly: true,
                          onTap: () async {
                            final result = await tdp.showCustomDatePicker(
                                context,
                                isFirstDate: true); //isFirstDate: true
                            if (result != null) {
                              toDateController.text =
                                  DateFormat('dd-MM-yyyy').format(tdp.toDate!);
                              fromDateController.text = result;
                            }
                          },
                        )),
                        Expanded(
                          child: CustomTextField(
                            nameController: toDateController,
                            name: "To Date",
                            readOnly: true,
                            onTap: () async {
                              final result =
                                  await tdp.showCustomDatePicker(context);
                              if (result != null) {
                                toDateController.text = result;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (fromDateController.text.isNotEmpty &&
                              toDateController.text.isNotEmpty) {
                            noOfDays = countSelectedDates();
                            tdp.updateBalnce(100000);
                            tdp.getNifty50TradeHistoryList(context);
                          } else {
                            Utils.showSnackBar(
                                context: context,
                                content: "Please select Date");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        child: const Text("Search")),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.deepOrange,
                        value: 'fixmargin',
                        groupValue: tdp.selectedRType,
                        onChanged: (value) {
                          tdp.updateSelectedRType(value);
                        },
                      ),
                      const Text(
                        'Fixed Margin',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.deepOrange,
                        value: 'fixlot',
                        groupValue: tdp.selectedRType,
                        onChanged: (value) {
                          tdp.updateSelectedRType(value);
                        },
                      ),
                      const Text(
                        'Fixed Lot',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.deepOrange,
                        value: 'cumilative',
                        groupValue: tdp.selectedRType,
                        onChanged: (value) {
                          tdp.updateSelectedRType(value);
                        },
                      ),
                      const Text(
                        'Cumilative',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
              if (tdp.nifty50tradeHistoryList.isEmpty) const EmptyWidget(),
              if (tdp.isLoading)
                const Expanded(
                    child: Center(child: CircularProgressIndicator())),
              if (!tdp.isLoading)
                Expanded(
                  child: ScrollbarTheme(
                    data: ScrollbarThemeData(
                      thumbColor: MaterialStateProperty.all(
                          Colors.deepOrange), // Set the color you desire
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _firstController,
                      thickness: 10,
                      trackVisibility: true,
                      interactive: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _firstController,
                        itemCount: tdp.nifty50tradeHistoryList.length,
                        itemBuilder: (context, index) {
                          return PLReportContainer(
                            tradeHistoryModel:
                                tdp.nifty50tradeHistoryList[index],
                            balenceAmount: tdp
                                .getRemainingAmount(
                                    tdp.nifty50tradeHistoryList, index)
                                .toDouble(),
                          ); //PLReportContainer(tradeHistoryModel:tdp.tradeHistoryModelList[index],);
                        },
                      ),
                    ),
                  ),
                ),
              Divider(),
              TradingReport(
                isExpanded: tdp.isExpanded,
                tradeList: tdp.nifty50tradeHistoryList,
                balence: tdp.getNifty50TotalProfitLoss().toDouble(),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                // margin: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    color: ColorManager.balck255,
                    borderRadius: BorderRadius.circular(12)),
                child: /*Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Flexible(
                                      child: Text(
                                        "Total P&L",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "₹ ${tdp.getTotalPL().toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: (tdp.getTotalPL().isNegative)
                                              ? Colors.red
                                              : Colors.green),
                                    ),
                                    const Flexible(
                                      child: Text(
                                        "Total Points",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                        tdp
                                            .getTotalPointsGains()
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: (tdp
                                                    .getTotalPointsGains()
                                                    .isNegative)
                                                ? Colors.red
                                                : Colors.green))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Flexible(
                                      child: Text(
                                        "Avg Points Per Day",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                        tdp
                                            .getAvgPointsPerDay()
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: (tdp
                                                    .getAvgPointsPerDay()
                                                    .isNegative)
                                                ? Colors.red
                                                : Colors.green))
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  tdp.updateIsExpaned(!tdp.isExpanded);
                                },
                                icon: !tdp.isExpanded
                                    ? Transform.rotate(
                                        angle: pi / 2,
                                        child: const Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.deepOrange,
                                        ))
                                    : Transform.rotate(
                                        angle: 3 * pi / 2,
                                        child: const Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.deepOrange,
                                        ))),
                          )
                        ],
                      ),
                      */
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Total P&L : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        Text(
                          "${tdp.getNifty50TotalProfitLoss().toStringAsFixed(2)} ₹",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color:
                                  (tdp.getNifty50TotalProfitLoss().isNegative)
                                      ? Colors.red
                                      : Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Total Points : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                            Text(
                              tdp
                                  .getTotalNifty50PointsGain()
                                  .toStringAsFixed(2),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: (tdp
                                          .getTotalNifty50PointsGain()
                                          .isNegative)
                                      ? Colors.red
                                      : Colors.green),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Avg point per day : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                  color: Colors.white),
                            ),
                            Text(
                              (tdp.getTotalNifty50PointsGain() / noOfDays)
                                  .toStringAsFixed(2),
                              style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: ((tdp.getTotalNifty50PointsGain() /
                                              noOfDays)
                                          .isNegative)
                                      ? Colors.red
                                      : Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          tdp.updateIsExpaned(!tdp.isExpanded);
                        },
                        icon: !tdp.isExpanded
                            ? Transform.rotate(
                                angle: pi / 2,
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.deepOrange,
                                ))
                            : Transform.rotate(
                                angle: 3 * pi / 2,
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.deepOrange,
                                )))
                  ],
                ),
              ),
            ],
          ),
        );
      default:
        return Center(
          child: Text(
            'No Data Available',
            style: TextStyle(color: Colors.white),
          ),
        );
    }
  }

  /* Widget getPostionTiles(List<KotakPositionModel> ps, String? userType) {
    final dp = Provider.of<DashboardProvider>(context);
    return userType == 'KOTAK'
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: ps.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: ColorManager.balck255,
                      child: ListTile(
                        title: Text(
                          ps[index].trdSym.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(ps[index].prod ?? ''),
                        trailing: Text(
                          "${getprofitloss(ps, index)} ₹",
                          style: TextStyle(
                              fontSize: 12,
                              color: getprofitloss(ps, index).isNegative
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      ),
                    );
                  },
                ),
                Card(
                  color: ColorManager.balck255,
                  child: ListTile(
                    title: const Text(
                      'P&L',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    trailing: Text(
                      "${dp.getTotalProfitLoss(kotakPositionList: ps)} ₹",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: (dp.getTotalProfitLoss(kotakPositionList: ps))
                                  .isNegative
                              ? Colors.red
                              : Colors.green),
                    ),
                  ),
                )
              ],
            ),
          )
        : Center(
            child: Card(
              elevation: 5,
              color: ColorManager.balck255,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.30,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Page Under Contruction',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'This page is under development phase it will be available to you soon',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  double getprofitloss(List<KotakPositionModel> positionList, int index) {
    try {
      double buyAmt = double.parse(positionList[index].buyAmt!);
      double sellAmt = double.parse(positionList[index].sellAmt!);

      double pnl = (sellAmt - buyAmt);

      return pnl;
    } catch (e) {
      return 0.0;
    }
  }
*/
}
