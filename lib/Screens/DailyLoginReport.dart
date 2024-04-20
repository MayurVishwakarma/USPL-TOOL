import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uspltool/Provider/DashbordProvider.dart';
import 'package:uspltool/Widgets/DailyLoginTile.dart';

import 'package:uspltool/utils/color_manager.dart';

class DailyLoginReportScreen extends StatefulWidget {
  const DailyLoginReportScreen({super.key});

  @override
  State<DailyLoginReportScreen> createState() => _DailyLoginReportScreenState();
}

class _DailyLoginReportScreenState extends State<DailyLoginReportScreen> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  void initState() {
    final dp = Provider.of<DashboardProvider>(context, listen: false);
    dp.getDailyLoginDetailsListnew();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownButton(),
                    ),
                    Expanded(
                        child: _buildDatePicker(
                            labelText: "From Date",
                            controller: fromDateController,
                            onTap: () async {
                              final result = await dp.showCustomDatePicker(
                                  context,
                                  isFirstDate: true); //isFirstDate: true
                              if (result != null) {
                                toDateController.text =
                                    DateFormat('dd-MM-yyyy').format(dp.toDate!);
                                fromDateController.text = result;
                              }
                            })),
                    Expanded(
                        child: _buildDatePicker(
                            labelText: "To Date",
                            controller: toDateController,
                            onTap: () async {
                              final result =
                                  await dp.showCustomDatePicker(context);
                              if (result != null) {
                                toDateController.text = result;
                              }
                            })),
                  ],
                ),
                SizedBox(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        dp.getDailyLoginDetailsListnew();
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
          ),
          if ((dp.dailyLoginList ?? []).isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Name: ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 180,
                            child: Text(
                              dp.dailyLoginList!.first.name.toString(),
                              style: const TextStyle(
                                  color: Colors.cyan, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Mobile: ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            dp.dailyLoginList!.first.mobileNo!,
                            style: const TextStyle(
                                color: Colors.cyan, fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Broker: ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        dp.dailyLoginList!.first.broker!,
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
          Container(
            height: 50,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(5), topEnd: Radius.circular(5))),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Login Date',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Login Time',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Margin',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: dp.dailyLoginList!.length,
            itemBuilder: (context, index) {
              return DailyLoginTile(userdata: dp.dailyLoginList![index]);
            },
          ))
        ],
      ),
    );
  }

  Widget _buildDropdownButton() {
    final dp = Provider.of<DashboardProvider>(context);
    return Expanded(
      child: DropdownButton(
        dropdownColor: ColorManager.balck255,
        isExpanded: true,
        underline: const Divider(color: Colors.transparent),
        hint: const Center(
          child: Text(
            'Select User',
            style: TextStyle(color: Colors.white),
          ),
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
        value: dp.selecteduser,
        onChanged: (newValue) {
          dp.updateSelecteduser(newValue.toString());
        },
        items: dp.backupList!.map((user) {
          return DropdownMenuItem(
            value: user.loginId,
            child: FittedBox(
              child: Text(
                "${user.name}\n (${user.loginId})",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDatePicker({
    required String labelText,
    required TextEditingController controller,
    required Function() onTap,
  }) {
    return Expanded(
      child: TextField(
        controller: controller,
        readOnly: true,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 11),
        onTap: onTap,
        decoration: InputDecoration(
          hintText: labelText,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 12),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          // focusedBorder: const OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.white),
          // ),
        ),
      ),
    );
  }
}
