// ignore_for_file: unnecessary_null_comparison, unused_local_variable, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uspltool/Models/api_data_model.dart';
import 'package:uspltool/Models/trade_api_data.dart';
import 'package:uspltool/Models/trade_history_model.dart';
import 'package:uspltool/Services/api_services.dart';

class TradeBookProvider extends ChangeNotifier {
  //Veriables
  List<TradeHistoryModel> _tradeHistoryList = [];
  List<TradeHistoryModel> _tradeHistoryModelList = [];
  bool _isLoading = true;
  num? _balence = 100000;
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _selectedRType = 'fixmargin';
  String? _selectedSection = 'BANKNIFTY';
  bool _isExpanded = false;

  //Geter-Seter
  bool get isLoading => _isLoading;
  List<TradeHistoryModel> get tradeHistoryList => _tradeHistoryList;
  List<TradeHistoryModel> get tradeHistoryModelList => _tradeHistoryModelList;
  List<TradeHistoryModel> _nifty50tradeHistoryList = [];
  List<TradeHistoryModel> get nifty50tradeHistoryList =>
      _nifty50tradeHistoryList;
  num? get balence => _balence;
  DateTime? get fromDate => _fromDate;
  DateTime? get toDate => _toDate;
  String? get selectedRType => _selectedRType;
  String? get selectedSection => _selectedSection;
  bool get isExpanded => _isExpanded;

  num getRemainingAmount(List<TradeHistoryModel> list, int index) {
    num temp = 0;
    num tempBalence = 100000;
    int counter = 0;
    int newIndex = index + 1;
    do {
      temp = tempBalence + (list[counter].profitLoss ?? 0);
      tempBalence = temp;
      counter++;
    } while (counter < newIndex);
    return temp;
  }

  num getnegetiveTreadcount(List<TradeHistoryModel> treadModel) {
    var totalcount;
    if (treadModel != null) {
      totalcount = treadModel
          .where((element) => (element.profitLoss ?? 0.0).isNegative)
          .length;
    }
    return totalcount;
  }

  updateIsExpaned(bool res) {
    _isExpanded = res;
    notifyListeners();
  }

  num getpositiveTradeCount(List<TradeHistoryModel> treadModel) {
    num? totalpostive;
    if (treadModel != null) {
      var totalcount = treadModel.length;
      var totalnegtive = treadModel
          .where((element) => (element.profitLoss ?? 0.0).isNegative)
          .length;
      totalpostive = totalcount - totalnegtive;
    }
    return (totalpostive ?? 0.0);
  }

  updateSelectedSecrionType(String? result) {
    _selectedSection = result;
    notifyListeners();
  }

  double getWinRate(int totalcount, int postivecount) {
    try {
      var winrate;
      winrate = (postivecount / totalcount) * 100;
      return winrate ?? 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  updateSelectedRType(String? result) {
    _selectedRType = result;
    notifyListeners();
  }

  num getNumberOfPositiveTrades(List<TradeHistoryModel> list) {
    final temp =
        list.where((e) => (e.profitLoss ?? 0).isNegative == false).toList();
    return temp.length;
  }

  num getNumberOfNegativeTrades(List<TradeHistoryModel> list) {
    final temp = list.where((e) => (e.profitLoss ?? 0).isNegative).toList();
    return temp.length;
  }

  num getTotalPointsGains() {
    num sum = 0;
    var temp = tradeHistoryModelList.map((e) => e.pointsGain).toList();
    for (var i in temp) {
      sum = sum + (i ?? 0);
    }
    return sum;
  }

  num getWinPercent(List<TradeHistoryModel> list) {
    final res = (getNumberOfPositiveTrades(list) / list.length) * 100;
    return res;
  }

  num getPercentPointGain(List<TradeHistoryModel> list) {
    num pointsgain, pointsloos;
    num sum = 0;
    num possum = 0;
    num result;

    var pointslooslist = list
        .where((element) => (element.pointsGain ?? 0.0).isNegative)
        .toList();
    var pointsgainlist = list
        .where((element) => (element.pointsGain ?? 0.0).isNegative == false)
        .toList();
    for (var i in pointslooslist) {
      sum = sum + (i.profitLoss ?? 0);
    }
    for (var i in pointsgainlist) {
      possum = possum + (i.profitLoss ?? 0);
    }

    pointsloos = sum;
    pointsgain = possum;

    result =
        (pointsgain - pointsloos.abs()) / (pointsgain + pointsloos.abs()) * 100;

    return result;
  }

  double getROIPercentage(double balance, double investment) {
    var result = (balance / investment) * 100;
    return result;
  }

  num getAvgPointsPerDay() {
    var days = toDate?.difference(fromDate!).inDays.abs();
    return getTotalPointsGains() / ((days ?? 0) + 1);
  }

  double getpercentpointgain(List<TradeHistoryModel> treadModel) {
    var pointsgain;
    var pointsloos;
    num sum = 0;
    num possum = 0;
    var result;
    try {
      var pointslooslist = treadModel
          .where((element) => (element.pointsGain ?? 0.0).isNegative)
          .toList();
      var pointsgainlist = treadModel
          .where((element) => (element.pointsGain ?? 0.0).isNegative == false)
          .toList();
      for (var i in pointslooslist) {
        sum = sum + (i.profitLoss ?? 0);
      }
      for (var i in pointsgainlist) {
        possum = possum + (i.profitLoss ?? 0);
      }

      pointsloos = sum;
      pointsgain = possum;

      result = (pointsgain - pointsloos.abs()) /
          (pointsgain + pointsloos.abs()) *
          100;

      return result ?? 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  double getroipercentage(double balance, double investment) {
    var totalbalance = ((investment + balance) - investment);
    var result = (totalbalance / investment) * 100;
    return result;
  }

  updateBalnce(num result) {
    _balence = result;
    // notifyListeners();
  }

  num getTotalPL() {
    num sum = 0;
    var temp = tradeHistoryModelList.map((e) => e.profitLoss).toList();
    for (var i in temp) {
      sum = sum + (i ?? 0);
    }
    // print("Total P&L $sum");
    return sum;
  }

  num getTotalPointsGain() {
    num sum = 0;
    var temp = tradeHistoryModelList.map((e) => e.pointsGain).toList();

    for (var i in temp) {
      sum = sum + (i ?? 0);
    }
    // print("POINTS GAIN $sum");
    return sum;
  }

  num getTotalNifty50PL() {
    num sum = 0;
    var temp = nifty50tradeHistoryList.map((e) => e.profitLoss).toList();
    for (var i in temp) {
      sum = sum + (i ?? 0);
    }
    return sum;
  }

  num getNifty50TotalProfitLoss() {
    num sum = 0;
    var temp = nifty50tradeHistoryList.map((e) => e.profitLoss).toList();
    for (var i in temp) {
      sum = sum + (i ?? 0);
    }
    // print("Total P&L $sum");
    return sum;
  }

  num getTotalNifty50PointsGain() {
    num sum = 0;
    var temp = nifty50tradeHistoryList.map((e) => e.pointsGain).toList();

    for (var i in temp) {
      sum = sum + (i ?? 0);
    }
    // print("POINTS GAIN $sum");
    return sum;
  }

  Future<ApiData?> getApiDAta() async {
    return ApiData(
        userId: '1',
        fromDate: fromDate ?? getFirstDate(),
        toDate: toDate ?? DateTime.now(),
        reportType: selectedRType.toString());
  }

  updateIsLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  updateDate({DateTime? from, DateTime? to}) {
    if (from != null) {
      _fromDate = from;
    }
    if (to != null) {
      _toDate = to;
    }
  }

  updateTradeHistory(List<TradeHistoryModel> newTradeHistoryList) {
    _tradeHistoryList.clear();
    _tradeHistoryList = newTradeHistoryList;
    notifyListeners();
  }

  updatePLReportList(List<TradeHistoryModel> newPlReportList) {
    _tradeHistoryModelList = newPlReportList;
    notifyListeners();
  }

  updateNiftyPLReportList(List<TradeHistoryModel> newPlReportList) {
    _nifty50tradeHistoryList = newPlReportList;
    notifyListeners();
  }

  getTradeHistoryList(BuildContext context) async {
    updateIsLoading(true);
    var apiData = await getApiDAta();
    if (context.mounted && apiData != null) {
      final result = await getTradeHistory(context, apiData);
      if (result != null) {
        updateTradeHistory(result);
      }
    }
    updateIsLoading(false);
  }

  Future<TradeApiData?> getTradeApiDAta() async {
    return TradeApiData(
        userId: '1',
        fromDate: fromDate ?? getFirstDate(),
        toDate: toDate ?? DateTime.now(),
        reportType: selectedRType ?? "fixmargin");
  }

  getTradeHistoryModelList(BuildContext context) async {
    updateIsLoading(true);
    var apiData = await getTradeApiDAta();
    if (context.mounted && apiData != null) {
      final result = await getPLReports(apiData);
      if (result != null) {
        updatePLReportList(result);
      }
    }
    updateIsLoading(false);
  }

  getNifty50TradeHistoryList(BuildContext context) async {
    updateIsLoading(true);
    var apiData = await getTradeApiDAta();
    if (context.mounted && apiData != null) {
      final result = await getNifty50PLReports(apiData);
      if (result != null) {
        updateNiftyPLReportList(result);
      }
    }
    updateIsLoading(false);
  }

  //date functions
  getFirstDateString() {
    return DateFormat("dd-MM-yyyy").format(DateTime.now());
  }

  getTodayDateString() {
    return DateFormat("dd-MM-yyyy").format(DateTime.now());
  }

  getFirstDate() {
    final now = DateTime.now();
    return now;
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
}
