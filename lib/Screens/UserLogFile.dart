import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uspltool/Provider/DashbordProvider.dart';
import 'package:uspltool/utils/color_manager.dart';

class UserLogSreen extends StatefulWidget {
  const UserLogSreen({super.key});

  @override
  State<UserLogSreen> createState() => _UserLogSreenState();
}

class _UserLogSreenState extends State<UserLogSreen> {
  @override
  void initState() {
    final dp = Provider.of<DashboardProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dp.updateLogText(null);
    });
    super.initState();
  }

  final TextEditingController _dateController = TextEditingController();
  String? pdfString;

  // var selectedUser;
  @override
  Widget build(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
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
                  value: dp.selectLoguser,
                  onChanged: (newValue) {
                    dp.updateSelectedLoguser(newValue ?? '');
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
              ),
              // _buildDropdownButton(),
              /*Expanded(
                child: DropdownButtonFormField<String>(
                  dropdownColor: ColorManager.balck255,
                  value: dp.selecteduser, // Maintain selected user value
                  style: const TextStyle(color: Colors.white),

                  onChanged: (newValue) {
                    dp.updateSelecteduser(newValue ?? '');
                    dp.updateUserName(newValue ?? '');
                  },
                  items: dp.backupList?.map((user) {
                    return DropdownMenuItem<String>(
                      value: user.loginId,
                      child: FittedBox(
                        child: Text(
                          "${user.name}\n (${user.loginId})",
                        ),
                      ),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Select User', // Update label text
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
             */
              const SizedBox(
                width: 20,
              ),
              _buildDateTimePicker(
                labelText: 'Select Date',
                controller: _dateController,
                onTap: () {
                  dp.selectDateNow(context).whenComplete(() => {
                        if (dp.selectedDate != null)
                          {
                            _dateController.text = DateFormat('yyyy-MM-dd')
                                .format(dp.selectedDate!)
                          }
                      });
                },
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 55,
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      final selectdate =
                          DateFormat("yyyy-MM-dd").format(dp.selectedDate!);
                      dp.updateFileName("${dp.userName}_$selectdate");
                      dp.getUserLogFileString(context).whenComplete(
                          () => dp.updateLogText(dp.pdfString ?? ''));
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    child: const Text("GET")),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        if (dp.pdfString != null)
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  dp.logText ?? "",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          )
      ],
    ));
  }

  /*Widget _buildDropdownButton() {
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
          dp.updateSelecteduser(newValue ?? '');
          dp.updateUserName(newValue ?? '');
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
*/
  Widget _buildDateTimePicker({
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
          enabledBorder: OutlineInputBorder(
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
