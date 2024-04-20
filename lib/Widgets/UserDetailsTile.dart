// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uspltool/Models/UserDetailsModel.dart';
import 'package:uspltool/Provider/DashbordProvider.dart';
import 'package:uspltool/utils/color_manager.dart';

class UserDetailTile extends StatefulWidget {
  final UserDetailsModel userdata;
  UserDetailTile({super.key, required this.userdata});

  @override
  State<UserDetailTile> createState() => _UserDetailTileState();
}

class _UserDetailTileState extends State<UserDetailTile> {
  @override
  void initState() {
    super.initState();
  }

  _getText(String text) {
    return Text(
      "${text} %",
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black),
    );
  }

  final TextEditingController _banknifty = TextEditingController();
  final TextEditingController _nifty = TextEditingController();
  final TextEditingController _finnifty = TextEditingController();
  final TextEditingController _midcap = TextEditingController();
  final TextEditingController _equity = TextEditingController();

  int _isBankNiftyOn = 0;
  int _isNiftyOn = 0;
  int _isFinNiftyOn = 0;
  int _isMidCapOn = 0;
  int _isEquityOn = 0;
  @override
  Widget build(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    // final user = widget.userdata;
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 260,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorManager.balck255, borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.userdata.name ?? '',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              Row(
                children: [
                  const Text(
                    'Status : ',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: (DateTime.tryParse(
                                widget.userdata.subscriptionDate ?? '')!
                            .isAfter(DateTime.now()))
                        ? Colors.green
                        : Colors.red,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      dp.getIsAutoModel(widget.userdata);
                      final isAuto = dp.isAutoModel;
                      updateAllocation();
                      showDialog(
                        context:
                            context, // Ensure that you have access to the context
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Update User Details",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Name: ${widget.userdata.name}',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  Text(
                                    'Broker: ${widget.userdata.broker}',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                            content: Form(
                              key: GlobalKey(),
                              child: Consumer<DashboardProvider>(
                                builder: (context, dp, child) {
                                  return SingleChildScrollView(
                                    child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: [
                                        const TableRow(children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              "Segments",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              "% Allocation",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              "Auto Trade",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ]),
                                        const TableRow(children: [
                                          Divider(),
                                          Divider(),
                                          Divider()
                                        ]),
                                        //*BankNifty
                                        TableRow(children: [
                                          const Text(
                                            "Bank Nifty",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 30,
                                            height: 40,
                                            child: TextField(
                                              controller: _banknifty,
                                              onChanged: (val) {
                                                widget.userdata.bANKNIFTY = val;
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide
                                                              .none),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  suffix: Text('%')),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Switch.adaptive(
                                              activeColor: Colors.green,
                                              inactiveThumbColor: Colors.red,
                                              value: dp
                                                  .getTrueFalse(_isBankNiftyOn),
                                              onChanged: (val) {
                                                dp.updateIsAutoModel(
                                                    dp.isAutoModel!.copyWith(
                                                        bnIsAuto: val ? 1 : 0));
                                                _isBankNiftyOn =
                                                    val == true ? 1 : 0;
                                              },
                                            ),
                                          )
                                        ]),
                                        const TableRow(children: [
                                          Divider(),
                                          Divider(),
                                          Divider()
                                        ]),
                                        //*Nifty
                                        TableRow(children: [
                                          const Text(
                                            "Nifty",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 30,
                                            height: 40,
                                            child: TextField(
                                              controller: _nifty,
                                              onChanged: (val) {
                                                widget.userdata.nIFTY = val;
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide
                                                              .none),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  suffix: Text('%')),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Switch.adaptive(
                                              activeColor: Colors.green,
                                              inactiveThumbColor: Colors.red,
                                              value:
                                                  dp.getTrueFalse(_isNiftyOn),
                                              onChanged: (value) {
                                                dp.updateIsAutoModel(
                                                    dp.isAutoModel!.copyWith(
                                                        nIsAuto:
                                                            value ? 1 : 0));
                                                _isNiftyOn =
                                                    value == true ? 1 : 0;
                                                // dp.updateNiftyAuto(value);
                                              },
                                            ),
                                          )
                                        ]),
                                        const TableRow(children: [
                                          Divider(),
                                          Divider(),
                                          Divider()
                                        ]),
                                        //*FinNifty
                                        TableRow(children: [
                                          const Text(
                                            "Nifty Fin",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 30,
                                            height: 40,
                                            child: TextField(
                                              controller: _finnifty,
                                              onChanged: (val) {
                                                widget.userdata.nIFTYFIN = val;
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide
                                                              .none),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  suffix: Text('%')),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Switch.adaptive(
                                              activeColor: Colors.green,
                                              inactiveThumbColor: Colors.red,
                                              value: dp
                                                  .getTrueFalse(_isFinNiftyOn),
                                              onChanged: (value) {
                                                dp.updateIsAutoModel(
                                                    dp.isAutoModel!.copyWith(
                                                        nfIsAuto:
                                                            value ? 1 : 0));
                                                _isFinNiftyOn =
                                                    value == true ? 1 : 0;
                                              },
                                            ),
                                          )
                                        ]),
                                        const TableRow(children: [
                                          Divider(),
                                          Divider(),
                                          Divider()
                                        ]),
                                        //*MidCap
                                        TableRow(children: [
                                          const Text(
                                            "Midcap",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 30,
                                            height: 40,
                                            child: TextField(
                                              controller: _midcap,
                                              textAlign: TextAlign.center,
                                              onChanged: (val) {
                                                widget.userdata.mIDCAP = val;
                                              },
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide
                                                              .none),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  suffix: Text('%')),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Switch.adaptive(
                                              activeColor: Colors.green,
                                              inactiveThumbColor: Colors.red,
                                              value:
                                                  dp.getTrueFalse(_isMidCapOn),
                                              onChanged: (value) {
                                                dp.updateIsAutoModel(
                                                    dp.isAutoModel!.copyWith(
                                                        mcIsAuto:
                                                            value ? 1 : 0));
                                                _isMidCapOn =
                                                    value == true ? 1 : 0;
                                              },
                                            ),
                                          )
                                        ]),
                                        const TableRow(children: [
                                          Divider(),
                                          Divider(),
                                          Divider()
                                        ]),
                                        //*Equity
                                        TableRow(children: [
                                          const Text(
                                            "Equity",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 30,
                                            height: 40,
                                            child: TextField(
                                              controller: _equity,
                                              onChanged: (val) {
                                                widget.userdata.eQUITY = val;
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide
                                                              .none),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  suffix: Text('%')),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Switch.adaptive(
                                              activeColor: Colors.green,
                                              inactiveThumbColor: Colors.red,
                                              value:
                                                  dp.getTrueFalse(_isEquityOn),
                                              onChanged: (value) {
                                                dp.updateIsAutoModel(
                                                    dp.isAutoModel!.copyWith(
                                                        eqIsAuto:
                                                            value ? 1 : 0));
                                                _isEquityOn =
                                                    value == true ? 1 : 0;
                                              },
                                            ),
                                          )
                                        ])

                                        /*TableRow(children: [
                                          const Text(
                                            "Bank Nifty",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 30,
                                            height: 40,
                                            child: TextField(
                                              controller: _banknifty,
                                              onChanged: (val) {
                                                widget.userdata.bANKNIFTY = val;
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide
                                                              .none),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  suffix: Text('%')),
                                            ),
                                          ),
                                          // _getText(
                                          //   (userdata.bANKNIFTY ?? "")
                                          //       .toString(),
                                          // ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Switch.adaptive(
                                              activeColor: Colors.green,
                                              inactiveThumbColor: Colors.red,
                                              value: dp
                                                  .getTrueFalse(_isBankNiftyOn),
                                              onChanged: (value) {},
                                            ),
                                          )
                                        ]),
                                        const TableRow(children: [
                                          Divider(),
                                          Divider(),
                                          Divider()
                                        ]),
                                        TableRow(children: [
                                          const Text(
                                            "Nifty",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          // _getText(
                                          //   (userdata.nIFTY ?? "").toString(),
                                          // ),
                                          SizedBox(
                                            width: 30,
                                            height: 40,
                                            child: TextField(
                                              controller: _nifty,
                                              onChanged: (val) {
                                                widget.userdata.nIFTY = val;
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide
                                                              .none),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  suffix: Text('%')),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Switch.adaptive(
                                              activeColor: Colors.green,
                                              inactiveThumbColor: Colors.red,
                                              value: dp.niftyauto!,
                                              onChanged: (value) {
                                                dp.updateNiftyAuto(value);
                                              },
                                            ),
                                          )
                                        ]),
                                        const TableRow(children: [
                                          Divider(),
                                          Divider(),
                                          Divider()
                                        ]),
                                        TableRow(children: [
                                          const Text(
                                            "Nifty Fin",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          // _getText(
                                          //   (userdata.nIFTYFIN ?? "")
                                          //       .toString(),
                                          // ),
                                          SizedBox(
                                            width: 30,
                                            height: 40,
                                            child: TextField(
                                              controller: _finnifty,
                                              onChanged: (val) {
                                                widget.userdata.nIFTYFIN = val;
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide
                                                              .none),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  suffix: Text('%')),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Switch.adaptive(
                                              activeColor: Colors.green,
                                              inactiveThumbColor: Colors.red,
                                              value: dp.finniftyauto!,
                                              onChanged: (value) {
                                                dp.updateFinNiftyAuto(value);
                                              },
                                            ),
                                          )
                                        ]),
                                        const TableRow(children: [
                                          Divider(),
                                          Divider(),
                                          Divider()
                                        ]),
                                        TableRow(children: [
                                          const Text(
                                            "Midcap",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          // _getText(
                                          //   (userdata.mIDCAP ?? "")
                                          //       .toString(),
                                          // ),
                                          SizedBox(
                                            width: 30,
                                            height: 40,
                                            child: TextField(
                                              controller: _midcap,
                                              textAlign: TextAlign.center,
                                              onChanged: (val) {
                                                widget.userdata.mIDCAP = val;
                                              },
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide
                                                              .none),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  suffix: Text('%')),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Switch.adaptive(
                                              activeColor: Colors.green,
                                              inactiveThumbColor: Colors.red,
                                              value: dp.midcapauto!,
                                              onChanged: (value) {
                                                dp.updateMidcapAuto(value);
                                              },
                                            ),
                                          )
                                        ]),
                                        const TableRow(children: [
                                          Divider(),
                                          Divider(),
                                          Divider()
                                        ]),
                                        TableRow(children: [
                                          const Text(
                                            "Equity",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          // _getText(
                                          //   (userdata.eQUITY ?? "")
                                          //       .toString(),
                                          // ),
                                          SizedBox(
                                            width: 30,
                                            height: 40,
                                            child: TextField(
                                              controller: _equity,
                                              onChanged: (val) {
                                                widget.userdata.eQUITY = val;
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide
                                                              .none),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  suffix: Text('%')),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Switch.adaptive(
                                              activeColor: Colors.green,
                                              inactiveThumbColor: Colors.red,
                                              value: dp.equityauto!,
                                              onChanged: (value) {
                                                dp.updateEquityAuto(value);
                                              },
                                            ),
                                          )
                                        ])
                                      */
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await dp.submitIsAuto(context,
                                      widget.userdata, dp.isAutoModel!);
                                  await dp.getUserDetailsListnew();
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Update"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )

                  /* IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                    onPressed: () async {
                      dp.updateBankNiftyAuto(
                          widget.userdata.isAuto == 1 ? true : false);
                      await showDialog(
                        context:
                            context, // Ensure that you have access to the context
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Update User Details"),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.40,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Consumer<DashboardProvider>(
                                    builder: (context, dp, child) {
                                      return Table(
                                        children: [
                                          const TableRow(children: [
                                            Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text(
                                                  "% Allocation",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                )),
                                            Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text(
                                                  "Margin",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                  textAlign: TextAlign.center,
                                                )),
                                            Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text(
                                                  "Auto Trade",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                  textAlign: TextAlign.right,
                                                )),
                                          ]),
                                          TableRow(children: [
                                            const Text("Bank Nifty"),
                                            _getText(
                                              (widget.userdata.bANKNIFTY ?? "")
                                                  .toString(),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Switch.adaptive(
                                                activeColor: Colors.green,
                                                inactiveThumbColor: Colors.red,
                                                value: dp.bankniftyauto!,
                                                onChanged: (value) {
                                                  dp.updateBankNiftyAuto(value);
                                                },
                                              ),
                                            )
                                          ]),
                                          TableRow(children: [
                                            const Text("Nifty"),
                                            _getText(
                                              (widget.userdata.nIFTY ?? "")
                                                  .toString(),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Switch.adaptive(
                                                activeColor: Colors.green,
                                                inactiveThumbColor: Colors.red,
                                                value: dp.niftyauto!,
                                                onChanged: (value) {
                                                  // ap.updateNifty(value);
                                                },
                                              ),
                                            )
                                          ]),
                                          TableRow(children: [
                                            const Text("Nifty Fin"),
                                            _getText(
                                              (widget.userdata.nIFTYFIN ?? "")
                                                  .toString(),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Switch.adaptive(
                                                activeColor: Colors.green,
                                                inactiveThumbColor: Colors.red,
                                                value: dp.finniftyauto!,
                                                onChanged: (value) {
                                                  // ap.updateNiftyFin(value);
                                                },
                                              ),
                                            )
                                          ]),
                                          TableRow(children: [
                                            const Text("Midcap"),
                                            _getText(
                                              (widget.userdata.mIDCAP ?? "")
                                                  .toString(),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Switch.adaptive(
                                                activeColor: Colors.green,
                                                inactiveThumbColor: Colors.red,
                                                value: dp.midcapauto!,
                                                onChanged: (value) {
                                                  // ap.updateMidcap(value);
                                                },
                                              ),
                                            )
                                          ]),
                                          TableRow(children: [
                                            const Text("Equity"),
                                            _getText(
                                              (widget.userdata.eQUITY ?? "")
                                                  .toString(),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Switch.adaptive(
                                                activeColor: Colors.green,
                                                inactiveThumbColor: Colors.red,
                                                value: dp.equityauto!,
                                                onChanged: (value) {
                                                  // ap.updateEquity(value);
                                                },
                                              ),
                                            )
                                          ])
                                        ],
                                      );
                                    },
                                  ),
                                  // Container(
                                  //   margin: EdgeInsets.symmetric(
                                  //       horizontal: 10, vertical: 5),
                                  //   padding: EdgeInsets.all(0),
                                  //   alignment: Alignment.centerRight,
                                  //   child: ElevatedButton(
                                  //       onPressed: () {
                                  //         app.submitIsAuto(context);
                                  //       },
                                  //       child: Text("Submit")),
                                  // )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await dp.submitIsAuto(context,
                                      widget.userdata, dp.bankniftyauto!);
                                  await dp.getUserDetailsListnew();
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Update"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
               */
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.userdata.broker ?? '',
                style: const TextStyle(color: Colors.amber, fontSize: 12),
              ),
              Row(
                children: [
                  const Text(
                    "Margin / Limit : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${(widget.userdata.margin ?? 0.0).toStringAsFixed(0)} / ${widget.userdata.investLimit}",
                    style: const TextStyle(color: Colors.cyan, fontSize: 12),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.userdata.mobileNo ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              Row(
                children: [
                  const Text(
                    "Login Id : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Text(
                    "${widget.userdata.loginId}",
                    style: const TextStyle(color: Colors.cyan, fontSize: 12),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Valid till : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat('dd-MMM-yyyy').format(
                        DateTime.tryParse(widget.userdata.subscriptionDate!) ??
                            DateTime.now()),
                    style: TextStyle(
                      fontSize: 12,
                      color: (DateTime.tryParse(
                                  widget.userdata.subscriptionDate ?? '')!
                              .isAfter(DateTime.now()))
                          ? Colors.green
                          : Colors.red,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Last Login : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.userdata.lastLogin != null
                        ? DateFormat('dd-MMM-yyyy\nhh:mm:ss a').format(
                            DateTime.tryParse(widget.userdata.lastLogin!)!
                                .add(const Duration(hours: 5, minutes: 30)),
                          )
                        : "", // Display an empty string if lastLogin is null
                    style: TextStyle(
                      color: DateFormat('dd-MM-yyyy').format((DateTime.tryParse(
                                      widget.userdata.lastLogin ?? '') ??
                                  DateTime.now())) ==
                              DateFormat('dd-MM-yyyy').format(DateTime.now())
                          ? Colors.green
                          : Colors.red,
                      fontSize: 12,
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    'BANKNIFTY',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.userdata.bANKNIFTY ?? 0} %",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.userdata.isAuto == 1 ? 'ON' : 'OFF'} ",
                    style: TextStyle(
                        color: widget.userdata.isAuto == 1
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  // Switch(
                  //   value: widget.userdata.isAuto == 1,
                  //   activeColor: Colors.green,
                  //   inactiveThumbColor: Colors.red,
                  //   onChanged: (value) {
                  //     dp.updateBankNiftyAuto(value);
                  //   },
                  // )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'NIFTY',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.userdata.nIFTY ?? 0} %",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${(widget.userdata.isNiftyOn == 1) ? 'ON' : 'OFF'} ",
                    style: TextStyle(
                        color: (widget.userdata.isNiftyOn == 1)
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  // Switch(
                  //   value: dp.niftyauto!,
                  //   activeColor: Colors.green,
                  //   inactiveThumbColor: Colors.red,
                  //   onChanged: (value) {
                  //     dp.updateNiftyAuto(value);
                  //   },
                  // )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'FINNIFTY',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.userdata.nIFTYFIN ?? 0} %",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${(widget.userdata.isFinNiftyOn == 1) ? 'ON' : 'OFF'} ",
                    style: TextStyle(
                        color: (widget.userdata.isFinNiftyOn == 1)
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  // Switch(
                  //   value: dp.finniftyauto!,
                  //   activeColor: Colors.green,
                  //   inactiveThumbColor: Colors.red,
                  //   onChanged: (value) {
                  //     dp.updateFinNiftyAuto(value);
                  //   },
                  // )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'MIDCAP',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.userdata.mIDCAP ?? 0} %",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${(widget.userdata.isMidCapOn == 1) ? 'ON' : 'OFF'} ",
                    style: TextStyle(
                        color: (widget.userdata.isMidCapOn == 1)
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  // Switch(
                  //   value: dp.midcapauto!,
                  //   activeColor: Colors.green,
                  //   inactiveThumbColor: Colors.red,
                  //   onChanged: (value) {
                  //     dp.updateMidcapAuto(value);
                  //   },
                  // )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Equity',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.userdata.eQUITY ?? 0} %",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${(widget.userdata.isEquityOn == 1) ? 'ON' : 'OFF'} ",
                    style: TextStyle(
                        color: (widget.userdata.isEquityOn == 1)
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  // Switch(
                  //   value: dp.equityauto!,
                  //   activeColor: Colors.green,
                  //   inactiveThumbColor: Colors.red,
                  //   onChanged: (value) {
                  //     dp.updateEquityAuto(value);
                  //   },
                  // )
                ],
              ),
            ],
          ),

          /*
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Auto Trading : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (userdata.isAuto ?? 0) == 1 ? 'ON' : 'OFF',
                    style: TextStyle(
                        color: (userdata.isAuto ?? 0) == 1
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12),
                  )
                ],
              ),
              /* const Row(
                children: [
                  Text(
                    "Lot % : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "BN: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "20% ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "NI: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "20% ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        " NIF: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "20% ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "MID: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "20% ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "EQ: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "20% ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              )
           */
            ],
          ),
         */
          Row(
            children: [
              const Text(
                "Login Device : ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(3.5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      (widget.userdata.deviceId ?? '')
                          .replaceAll('{', '')
                          .replaceAll('}', ''),
                      style: const TextStyle(color: Colors.amber),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  updateAllocation() {
    _banknifty.text = widget.userdata.bANKNIFTY ?? '';
    _nifty.text = widget.userdata.nIFTY ?? '';
    _finnifty.text = widget.userdata.nIFTYFIN ?? '';
    _midcap.text = widget.userdata.mIDCAP ?? '';
    _equity.text = widget.userdata.eQUITY ?? '';
  }
}
