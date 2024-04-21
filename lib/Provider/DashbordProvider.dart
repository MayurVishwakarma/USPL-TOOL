// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uspltool/Models/CompanyMasterModel.dart';

import 'package:uspltool/Models/DailyLoginModel.dart';
import 'package:uspltool/Models/UserDetailsModel.dart';
import 'package:uspltool/Models/isAutoUpdateModel.dart';
import 'package:uspltool/Screens/DailyLoginReport.dart';
import 'package:uspltool/Screens/EquityAchiverScreen.dart';
import 'package:uspltool/Screens/OptionPriceTracker.dart';
import 'package:uspltool/Screens/TreadReport.dart';
import 'package:uspltool/Screens/UserLogFile.dart';
import 'package:uspltool/Screens/UserReport.dart';
import 'package:uspltool/Services/api_services.dart';
import 'package:uspltool/Widgets/utils.dart';

enum Keys {
  user,
  apiKey,
  accessToken,
  requestToken,
  apiSecret,
  userType,
  zerodha,
  aliceblue,
  iciciDirect,
  zerodhaMargin,
  kotakUser
}

class DashboardProvider extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  String? _selecteduser;
  String? _selectedLoguser;
  String? get selectLoguser => _selectedLoguser;
  String? get selecteduser => _selecteduser;
  DateTime? _fromDate;
  DateTime? _toDate;
  bool? _bankniftyauto = true;
  bool? _niftyauto = false;
  bool? _finniftyauto = false;
  bool? _midcapauto = false;
  bool? _equityauto = false;
  String? _logText;
  String? _pdfString;
  String? _fileName;
  String? _userName;
  String? _broker;
  String? _selectedExhange;
  String? _selectedSection = 'BANKNIFTY';
  // int? _selectedCompany;
  IsAutoModel? _isAutoModel;
  IsAutoModel? get isAutoModel => _isAutoModel;
  List<UserDetailsModel>? _userDetailsList = [];
  List<DailyLoginModel>? _dailyLoginList = [];
  List<CompanyMasterModel>? _allcompany = [];
  final List<String> _dropdownItems = ['NSE', 'BSE'];
  List<UserDetailsModel>? get userDetailsList => _userDetailsList;
  List<UserDetailsModel>? _backupList = [];
  final List<CompanyMasterModel> _backupComanyList = [];
  List<UserDetailsModel>? get backupList => _backupList;
  List<CompanyMasterModel>? get backupComanyList => _backupComanyList;
  String? get logText => _logText;
  List<DailyLoginModel>? get dailyLoginList => _dailyLoginList;
  List<Widget> get screens => _screens;
  List<String> get appbar => _appbar;
  String? get pdfString => _pdfString;
  DateTime? get fromDate => _fromDate;
  DateTime? get toDate => _toDate;
  bool? get bankniftyauto => _bankniftyauto;
  bool? get niftyauto => _niftyauto;
  bool? get finniftyauto => _finniftyauto;
  bool? get midcapauto => _midcapauto;
  bool? get equityauto => _equityauto;
  String? get fileName => _fileName;
  String? get userName => _userName;
  String? get broker => _broker;
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  String? get selectedExchange => _selectedExhange;
  String? get selectedSection => _selectedSection;

  List<String> get dropdownItems => _dropdownItems;
  List<CompanyMasterModel> get allcomapny => _allcompany ?? [];
  // int? get selectedCompany => _selectedCompany;

  final List<Widget> _screens = [
    const UserReportScren(),
    const DailyLoginReportScreen(),
    const TradeReportScreen(),
    const PriceTrackerScreen(),
    const UserLogSreen(),
    const EquityAchiverScreen()
  ];

  final List<String> _appbar = [
    'User Report',
    'Daily Login Report',
    'Tread Report',
    'Price Tracker',
    'User Logs',
    'Equity Achiver'
  ];

  getDailyLoginDetailsListnew() async {
    final data = await getDailyLoginDetailsList(
        selecteduser,
        DateFormat('yyyy-MM-dd').format(fromDate!),
        DateFormat('yyyy-MM-dd').format(toDate!));
    updateDailyLoginData(data);
  }

  updateDailyLoginData(List<DailyLoginModel> list) {
    _dailyLoginList = list;
    notifyListeners();
  }

  updateSelecteduser(String? res) {
    _selecteduser = res;
    notifyListeners();
  }

  updateSelectedLoguser(String? res) {
    _selectedLoguser = res;
    UserDetailsModel userDetails =
        backupList!.where((element) => element.loginId == res).first;
    _userName = ("${userDetails.userId}_${userDetails.firstName}");
    _broker = userDetails.broker;
    notifyListeners();
  }

  updateLogText(String? res) {
    try {
      _logText = utf8.decode(base64.decode((res ?? '').replaceAll('"', '')));
    } catch (e) {
      _logText = 'No Data Found';
    }
    notifyListeners();
  }

  updateFileName(String res) {
    _fileName = res;
    notifyListeners();
  }

  updatePageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  }

  updatepdfString(String? res) {
    _pdfString = res;
    notifyListeners();
  }

  updateTradeData(List<UserDetailsModel> list) {
    _userDetailsList = list;
    notifyListeners();
  }

  getUserDetailsListnew() async {
    final data = await getUserDetailsList();
    updateTradeData(data);
    _backupList = data;
  }

  Future getUserLogFileString(BuildContext context) async {
    print(fileName);
    final data =
        await GetPDFbyPath(context, fileName!, broker!, selectedSection!);
    updatepdfString(data.replaceAll('""', ''));
  }

  // updateUserName(String? res) {
  //   if (res != null) {
  //     UserDetailsModel userDetails =
  //         backupList!.where((element) => element.loginId == res).first;
  //     _userName = ("${userDetails.userId}_${userDetails.firstName}");
  //     _broker = userDetails.broker;
  //     notifyListeners();
  //   } else {}
  // }

  updateBankNiftyAuto(bool res) {
    _bankniftyauto = res;
    notifyListeners();
  }

  updateNiftyAuto(bool res) {
    _niftyauto = res;
    notifyListeners();
  }

  updateFinNiftyAuto(bool res) {
    _finniftyauto = res;
    notifyListeners();
  }

  updateMidcapAuto(bool res) {
    _midcapauto = res;
    notifyListeners();
  }

  updateEquityAuto(bool res) {
    _equityauto = res;
    notifyListeners();
  }

  updateselectedDate(DateTime d) {
    _selectedDate = d;
    // notifyListeners();
  }

  updateIsAutoModel(IsAutoModel? newIsAutoModel) {
    _isAutoModel = newIsAutoModel;
    notifyListeners();
  }

  searchUser(String name) {
    if ((_backupList ?? []).isNotEmpty) {
      _userDetailsList = _backupList;
    }
    final templist = (userDetailsList ?? []).where((e) {
      if ((e.name ?? "").toLowerCase().contains(name.toLowerCase())) {
        return true;
      }
      return false;
    }).toList();
    updateTradeData(templist);
  }

  searchCompany(String name) {
    if ((_backupComanyList).isNotEmpty) {
      _allcompany = _backupComanyList;
    }
    final templist = (allcomapny).where((e) {
      if ((e.symbol ?? "").toLowerCase().contains(name.toLowerCase())) {
        return true;
      }
      return false;
    }).toList();
    updateCompanyListData(templist);
  }

  updateDate({DateTime? from, DateTime? to}) {
    if (from != null) {
      _fromDate = from;
    }
    if (to != null) {
      _toDate = to;
    }
  }

  Future<String?> showCustomDatePicker(BuildContext context,
      {bool isFirstDate = false}) async {
    final date = await showDatePicker(
        context: context,
        initialDate: (isFirstDate)
            ? fromDate ?? DateTime.now()
            : toDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: (isFirstDate)
            ? DateTime(2042)
            : fromDate!.add(const Duration(days: 29)));

    if (date != null) {
      if (isFirstDate == true) {
        updateDate(from: date);
        // Automatically set to date to 30 days from the selected from date
        DateTime maxToDate = date.add(const Duration(days: 29));
        if (toDate == null || toDate!.isAfter(maxToDate)) {
          updateDate(to: maxToDate);
        }
      } else {
        updateDate(to: date);
      }
      return DateFormat('dd-MM-yyyy').format(date);
    } else {
      return null;
    }
  }

  getIsAutoModel(UserDetailsModel? user) {
    if (user != null) {
      final newModel = IsAutoModel(
          loginId: user.loginId ?? "",
          bnPercent: user.bANKNIFTY,
          nfPercent: user.nIFTYFIN,
          nPercent: user.nIFTY,
          eqPercent: user.eQUITY,
          mcPercent: user.mIDCAP,
          bnIsAuto: user.isAuto,
          eqIsAuto: user.isEquityOn,
          mcIsAuto: user.isMidCapOn,
          nIsAuto: user.isNiftyOn,
          nfIsAuto: user.isFinNiftyOn);
      updateIsAutoModel(newModel);
    } else {
      return null;
    }
  }
  // IsAutoModel? getIsAutoModel(UserDetailsModel? user) {
  //   if (user != null) {
  //     final newModel = IsAutoModel(
  //         loginId: user.loginId ?? "",
  //         bnPercent: user.bANKNIFTY,
  //         nfPercent: user.nIFTYFIN,
  //         nPercent: user.nIFTY,
  //         eqPercent: user.eQUITY,
  //         mcPercent: user.mIDCAP,
  //         bnIsAuto: (bankniftyauto == true) ? 1 : 0,
  //         eqIsAuto: (equityauto == true) ? 1 : 0,
  //         mcIsAuto: (midcapauto == true) ? 1 : 0,
  //         nIsAuto: (niftyauto == true) ? 1 : 0,
  //         nfIsAuto: (finniftyauto == true) ? 1 : 0);
  //     return newModel;
  //   } else {
  //     return null;
  //   }
  // }

  getTrueFalse(int? i) {
    if (i == 1) {
      return true;
    }
    return false;
  }

  submitIsAuto(
      BuildContext context, UserDetailsModel? user, IsAutoModel data) async {
    // data = bankNifty ? 1 : 0;
    if (user != null) {
      // final data = getIsAutoModel(user);
      final res = await updateAutoTrade(data.toJson());
      if (res == true) {
        Utils.showSnackBar(
            content: "update successfully!",
            context: context,
            color: Colors.green);
      }
    }
  }

  Future updateIsLocal(BuildContext context, int userId, int isLocal) async {
    try {
      final res = await updateTradeLocation(userId, isLocal);
      if (res == true) {
        Utils.showSnackBar(context: context, content: 'Updated Succesfully');
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool>? updateCommanMessage(BuildContext context, String? message) {
    if (message != null) {
      final res = updateCommanMsg(message);
      return res;
    }
    return null;
  }

  Future<bool>? updateUserMessage(
      BuildContext context, int? userId, String? message) {
    if (message != null) {
      final res = updateUserMsg(userId!, msg: message);
      return res;
    }
    return null;
  }

  updateCompanyListData(List<CompanyMasterModel> list) {
    _allcompany = list;
    notifyListeners();
  }

  getCompanyList() async {
    final data = await getAllCompanyList();
    updateCompanyListData(data);
  }

  updateSelectedSecrionType(String? result) {
    _selectedSection = result;
    notifyListeners();
  }

  Future<void> selectDateNow(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      updateselectedDate(picked);
    }
  }

  updateselectedItem(String? result) {
    _selectedExhange = result;
    notifyListeners();
  }

  // updateSelectedCompany(int res) {
  //   _selectedCompany = res;
  //   notifyListeners();
  // }

  Future<bool>? updateSelectedCompanyData(BuildContext context, int? id,
      String? symbol, String? exchange, String? companyName) {
    if (companyName != null) {
      final res = updateCompanyDetails(id!, symbol!, exchange!, companyName);
      return res;
      // if (res == true) {
      //   getCompanyList();
      //   updateSelectedCompany(0);
      //   Utils.showSnackBar(
      //       content: "update successfully!",
      //       context: context,
      //       color: Colors.green);
      // }
    }
    return null;
  }

  Future<bool>? deleteSelectedCompanyData(
      BuildContext context, String? symbol, String? exchange) {
    if (symbol != null) {
      final res = deleteCompanyDetails(symbol, exchange!);
      return res;
      // if (res == true) {
      //   getCompanyList();
      //   Utils.showSnackBar(
      //       content: "Record Deleted successfully!",
      //       context: context,
      //       color: Colors.green);
      // }
    }
    return null;
  }

  Future<bool>? insertCompanyData(BuildContext context, String? symbol,
      String? exchange, String? companyName) {
    if (companyName != null) {
      final res = insertCompanyDetails(symbol!, exchange!, companyName);
      return res;
    }
    return null;
  }
}
