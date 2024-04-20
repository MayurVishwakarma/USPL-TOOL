// ignore_for_file: deprecated_member_use, unnecessary_brace_in_string_interps, file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:uspltool/Provider/DashbordProvider.dart';
import 'package:uspltool/utils/color_manager.dart';

import '../Widgets/utils.dart';

class EquityAchiverScreen extends StatefulWidget {
  const EquityAchiverScreen({super.key});

  @override
  State<EquityAchiverScreen> createState() => _EquityAchiverScreenState();
}

class _EquityAchiverScreenState extends State<EquityAchiverScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController symbolTextEditor = TextEditingController();
  TextEditingController companyTextEditor = TextEditingController();
  @override
  void initState() {
    super.initState();
    final dp = Provider.of<DashboardProvider>(context, listen: false);
    // dp.updateselectedItem(null);
    dp.getCompanyList();
  }

  @override
  Widget build(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _insertcard(context);
                });
          },
          child: const Icon(Icons.add),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            dp.getCompanyList();
            // dp.updateselectedItem(null);
            // dp.updateSelectedCompany(0);
            searchController.clear();
          },
          child: Column(
            children: [
              /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextFormField(
                        controller: symbolTextEditor,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Symbol",
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.19,
                        child: _buildDropdownButton()),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: companyTextEditor,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: 'Company',
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    /*SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            dp.insertCompanyData(context, symbolTextEditor.text,
                                dp.selectedExchange, companyTextEditor.text);
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepOrange),
                          child: const Text("Insert")),
                    ),*/

                    SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            dp.updateSelectedCompanyData(
                                context,
                                dp.selectedCompany,
                                symbolTextEditor.text,
                                dp.selectedExchange,
                                companyTextEditor.text);
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepOrange),
                          child: const Text("Edit")),
                    )
                  ],
                ),
              ),
              */
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: GestureDetector(
                        onTap: () {
                          dp.searchCompany(searchController.text);
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 25,
                        )),
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ListView.builder(
                    itemCount: dp.allcomapny.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        color: ColorManager.balck255,
                        child: SizedBox(
                          // height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Text(
                                    "${dp.allcomapny[index].symbol}",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(color: Colors.white),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Text(
                                  "${dp.allcomapny[index].exchange ?? '-'}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                "${dp.allcomapny[index].companyName ?? '-'}",
                                style: const TextStyle(color: Colors.white),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    onPressed: () async {
                                      symbolTextEditor.text =
                                          dp.allcomapny[index].symbol ?? '';
                                      companyTextEditor.text =
                                          dp.allcomapny[index].companyName ??
                                              '';
                                      dp.updateselectedItem(
                                          dp.allcomapny[index].exchange);
                                      await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return _editcard(context, index);
                                          });
                                      // dp.deleteSelectedCompanyData(
                                      //     context,
                                      //     dp.allcomapny[index].symbol,
                                      //     dp.allcomapny[index].exchange);
                                    },
                                    icon: const Icon(
                                      Icons.more_vert_rounded,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _insertcard(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Insert Compnay Data'),
      ),
      content: Form(
        key: GlobalKey(),
        child: Consumer<DashboardProvider>(
          builder: (context, dp, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: symbolTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Symbol",
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildDropdownButton(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: companyTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: 'Company',
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (symbolTextEditor.text.isNotEmpty &&
                companyTextEditor.text.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Insert'),
                    content: Text(
                        'Are you sure you want to insert this record in the list.'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            dp
                                .insertCompanyData(
                                    context,
                                    symbolTextEditor.text,
                                    dp.selectedExchange,
                                    companyTextEditor.text)
                                ?.then((value) async {
                              await Utils.showSnackBar(
                                  content: "Inserted successfully!",
                                  context: context,
                                  color: Colors.green);
                              await dp.getCompanyList();
                              symbolTextEditor.clear();
                              companyTextEditor.clear();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          },
                          child: Text('Sure')),
                      TextButton(
                          onPressed: () {
                            symbolTextEditor.clear();
                            companyTextEditor.clear();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancle'))
                    ],
                  );
                },
              );
            }
          },
          child: const Text("Insert"),
        ),
        TextButton(
          onPressed: () {
            symbolTextEditor.clear();
            companyTextEditor.clear();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  Widget _editcard(BuildContext context, int index) {
    final dp = Provider.of<DashboardProvider>(context);
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Edit Compnay Data'),
      ),
      content: Form(
        key: GlobalKey(),
        child: Consumer<DashboardProvider>(
          builder: (context, dp, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: symbolTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Symbol",
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildDropdownButton(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: companyTextEditor,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: 'Company',
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (symbolTextEditor.text.isNotEmpty &&
                companyTextEditor.text.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Update'),
                    content: Text("Are you sure"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            dp
                                .updateSelectedCompanyData(
                                    context,
                                    dp.allcomapny[index].id,
                                    symbolTextEditor.text,
                                    dp.selectedExchange,
                                    companyTextEditor.text)
                                ?.then((value) async {
                              await Utils.showSnackBar(
                                  content: "update successfully!",
                                  context: context,
                                  color: Colors.green);
                              await dp.getCompanyList();
                              symbolTextEditor.clear();
                              companyTextEditor.clear();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          },
                          child: Text('Sure')),
                      TextButton(
                          onPressed: () {
                            symbolTextEditor.clear();
                            companyTextEditor.clear();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancle'))
                    ],
                  );
                },
              );
            } else {
              print('NO CompanyName');
            }
          },
          child: const Text("Update"),
        ),
        TextButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Delete'),
                  content: Text("Are you sure you want to delete this record."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          dp
                              .deleteSelectedCompanyData(
                            context,
                            symbolTextEditor.text,
                            dp.selectedExchange,
                          )
                              ?.then((value) async {
                            await Utils.showSnackBar(
                                content: "Record Deleted successfully!",
                                context: context,
                                color: Colors.green);
                            await dp.getCompanyList();
                            symbolTextEditor.clear();
                            companyTextEditor.clear();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text('Sure')),
                    TextButton(
                        onPressed: () {
                          symbolTextEditor.clear();
                          companyTextEditor.clear();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancle'))
                  ],
                );
              },
            );
          },
          child: const Text("Delete"),
        ),
        TextButton(
          onPressed: () {
            symbolTextEditor.clear();
            companyTextEditor.clear();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  Widget _buildDropdownButton() {
    final dp = Provider.of<DashboardProvider>(context);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(5.5),
        child: DropdownButton(
          dropdownColor: ColorManager.whiteA700,
          isExpanded: true,
          underline: const Divider(color: Colors.transparent),
          hint: const Text(
            'Exchange',
            style: TextStyle(color: Colors.black),
          ),
          style: const TextStyle(color: Colors.black),
          value: dp.selectedExchange,
          onChanged: (newValue) {
            dp.updateselectedItem(newValue.toString());
          },
          items: dp.dropdownItems.map((key) {
            return DropdownMenuItem(
              value: key,
              child: FittedBox(
                child: Text(
                  key,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
