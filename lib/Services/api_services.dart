import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:uspltool/Models/CompanyMasterModel.dart';
import 'package:uspltool/Models/DailyLoginModel.dart';
import 'package:uspltool/Models/OptionPriceModel.dart';
import 'package:uspltool/Models/TradeDataModel.dart';
import 'package:uspltool/Models/UserDetailsModel.dart';
import 'package:uspltool/Models/api_data_model.dart';
import 'package:uspltool/Models/trade_api_data.dart';
import 'package:uspltool/Models/trade_api_data_equity.dart';
import 'package:uspltool/Models/trade_history_model.dart';

const TOKEN =
    "03ti9vnhmrwq0qhinzsw5jkj0cad97jtl1n0fpywzxloj4m0yi7kj9b0pk0m623r0elmq";

Future<List<TradeDataModel>> getTradeDataBydate(String date) async {
  try {
    final response = await http.get(
        Uri.parse('http://bn.usplbot.com/gettradedatabydate/$TOKEN/$date'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<TradeDataModel> result = <TradeDataModel>[];
      result = (json['data'] as List)
          .map((e) => TradeDataModel.fromJson(e))
          .toList();
      return result;
    } else {
      throw Exception('Failed to Load API');
    }
  } catch (e) {
    throw Exception('Failed to Load API');
  }
}

Future<List<UserDetailsModel>> getUserDetailsList() async {
  try {
    final response =
        await http.get(Uri.parse('http://bn.usplbot.com/allusers/$TOKEN'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<UserDetailsModel> result = <UserDetailsModel>[];
      result = (json['data'] as List)
          .map((e) => UserDetailsModel.fromJson(e))
          .toList();
      return result;
    } else {
      throw Exception('Failed to Load API');
    }
  } catch (e) {
    throw Exception('Failed to Load API');
  }
}

Future<List<OptionPriceModel>> getTradePrice(
    String instrument, DateTime fromdate, DateTime todate) async {
  try {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "instrument": instrument,
      "fromDate": DateFormat("yyyy-MM-dd HH:mm:ss").format(fromdate),
      "toDate": DateFormat("yyyy-MM-dd HH:mm:ss").format(todate),
    });
    var dio = Dio();
    var response = await dio.request(
      'http://bn.usplbot.com/getTradePrice/$TOKEN',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
      final list = (response.data['data'] as List)
          .map((e) => OptionPriceModel.fromJson(e))
          .toList();

      return list;
    } else {}
    return [];
  } catch (e) {
    print(e);
    throw Exception('Failed to load API');
  }
}

Future<List<TradeHistoryModel>> getTradeHistory(
    BuildContext context, ApiData result) async {
  try {
    var headers = {'Content-Type': 'application/json'};
    var data = result;
    var dio = Dio();
    var response = await dio.request(
      'http://bn.usplbot.com/tradeHistory/$TOKEN',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
      final list = (response.data['data'] as List)
          .map((e) => TradeHistoryModel.fromJson(e))
          .toList();

      return list;
    } else {}
    return [];
  } catch (e) {
    print(e);
    throw Exception('Failed to load API');
  }
}

Future<List<TradeHistoryModel>?> getPLReports(TradeApiData apiData) async {
  try {
    var headers = {'Content-Type': 'application/json'};
    var data = apiData;
    var dio = Dio();
    var response = await dio.request(
      'http://bn.usplbot.com/trendReport/$TOKEN',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
      final list = (response.data['data'] as List)
          .map((e) => TradeHistoryModel.fromJson(e))
          .toList();

      return list;
    } else {}
    return [];
  } catch (e) {
    print(e);
    throw Exception('Failed to load API');
  }
}

Future<List<TradeHistoryModel>?> getNifty50PLReports(
    TradeApiData apiData) async {
  try {
    var headers = {'Content-Type': 'application/json'};
    var data = apiData;
    var dio = Dio();
    var response = await dio.request(
      'http://bn.usplbot.com/getNiftyFiftyTradeData/$TOKEN',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
      final list = (response.data['data'] as List)
          .map((e) => TradeHistoryModel.fromJson(e))
          .toList();

      return list;
    } else {}
    return [];
  } catch (e) {
    print(e);
    throw Exception('Failed to load API');
  }
}

Future<List<DailyLoginModel>> getDailyLoginDetailsList(
    String? loginId, String? fromdate, String? todate) async {
  try {
    final response = await http.get(Uri.parse(
        'http://bn.usplbot.com/userLoginHistory/$TOKEN/$loginId/$fromdate/$todate'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<DailyLoginModel> result = <DailyLoginModel>[];
      result = (json['data'] as List)
          .map((e) => DailyLoginModel.fromJson(e))
          .toList();
      return result;
    } else {
      throw Exception('Failed to Load API');
    }
  } catch (e) {
    throw Exception('Failed to Load API');
  }
}

Future<bool> updateAutoTrade(Map<String, dynamic> body) async {
  try {
    var headers = {
      'Cookie':
          'connect.sid=s%3AIvsgfKIUhCYfVTmABTGzFqdMZ_7IQ9sW.zEQsIndtjn37adlO3g7b4s0m1XMDgeaOSfmaTd6HMjc'
    };
    var dio = Dio();
    var response = await dio.request(
      'http://bn.usplbot.com/auto_trade/$TOKEN',
      data: body,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusMessage);
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

Future<List<TradeHistoryModel>?> getEquityPLReports(
    EquityTradeApiData apiData) async {
  try {
    var headers = {'Content-Type': 'application/json'};
    var data = apiData;
    var dio = Dio();
    var response = await dio.request(
      'http://bn.usplbot.com/getEquityTrade/$TOKEN',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
      final list = (response.data['data'] as List)
          .map((e) => TradeHistoryModel.fromJson(e))
          .toList();

      return list;
    } else {}
    return [];
  } catch (e) {
    print(e);
    throw Exception('Failed to load API');
  }
}

Future<String> GetPDFbyPath(BuildContext context, String filename,
    String broker, String section) async {
  String pdf64base = "";
  try {
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://65.109.34.110:3006/api/Image/GetImage?imgPath=C:\\USPL\\AutoTradeLogic\\$section\\$broker\\Logs\\${filename}.txt'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      pdf64base = await response.stream.bytesToString();
    } else {}
  } catch (ex) {}
  return pdf64base;
}

// Future<dynamic> updateAutoTrade(String username, bool data) async {
//   try {
//     var isAuto = data ? 1 : 0;
//     final result = await _apiRequest.updateAutoTrade(isAuto, username);
//     if (result.status == "Success") {
//       return result.data;
//     } else {
//       return null;
//     }
//   } catch (e) {
//     return null;
//   }
// }
Future<List<CompanyMasterModel>> getAllCompanyList() async {
  try {
    final response =
        await http.get(Uri.parse('http://bn.usplbot.com/companyList/$TOKEN'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<CompanyMasterModel> result = <CompanyMasterModel>[];
      result = (json['data'] as List)
          .map((e) => CompanyMasterModel.fromJson(e))
          .toList();
      return result;
    } else {
      throw Exception('Failed to Load API');
    }
  } catch (e) {
    throw Exception('Failed to Load API');
  }
}

Future<bool> updateCompanyDetails(
    int id, String symbol, String exchange, String comapnyName) async {
  try {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "id": id,
      "symbol": symbol,
      "exchange": exchange,
      "name": comapnyName
    });
    var dio = Dio();
    var response = await dio.request(
      'http://bn.usplbot.com/updateCompanyData/$TOKEN',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    print(e);
    throw Exception('Failed to load API');
  }
}

Future<bool> deleteCompanyDetails(String symbol, String exchange) async {
  try {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"symbol": symbol, "exchange": exchange});
    var dio = Dio();
    var response = await dio.request(
      'http://bn.usplbot.com/deleteCompanyData/$TOKEN',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    print(e);
    throw Exception('Failed to load API');
  }
}

Future<bool> insertCompanyDetails(
    String symbol, String exchange, String comapnyName) async {
  try {
    var headers = {'Content-Type': 'application/json'};
    var data = json
        .encode({"symbol": symbol, "exchange": exchange, "name": comapnyName});
    var dio = Dio();
    var response = await dio.request(
      'http://bn.usplbot.com/insertCompanyData/$TOKEN',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    print(e);
    throw Exception('Failed to load API');
  }
}

Future<bool> updateTradeLocation(int userId, int isLocal) async {
  try {
    var headers = {'Content-Type': 'application/json'};

    var dio = Dio();
    var response = await dio.request(
      'http://bn.usplbot.com/location/$TOKEN/$userId/$isLocal',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    print(e);
    throw Exception('Failed to load API');
  }
}

Future<bool> updateCommanMsg(String msg) async {
  try {
    var headers = {'Content-Type': 'application/json'};

    var dio = Dio();
    var response = await dio.request(
      'http://bn.usplbot.com/common_message/$TOKEN/$msg',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    print(e);
    throw Exception('Failed to load API');
  }
}

Future<bool> updateUserMsg(int userId, {String? msg = ' '}) async {
  try {
    var headers = {'Content-Type': 'application/json'};

    var dio = Dio();
    var response = await dio.request(
      'http://bn.usplbot.com/user_message/$TOKEN/$userId/$msg',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (e) {
    print(e);
    throw Exception('Failed to load API');
  }
}
