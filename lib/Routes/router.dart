import 'package:flutter/material.dart';

import 'package:uspltool/Screens/DashboardManager.dart';
import 'package:uspltool/Screens/Splashscreen.dart';

class RouteGenerator {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => const Splashscreen(),
        );
      case DashboardManager.routeName:
        return MaterialPageRoute(
          builder: (context) => DashboardManager(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text(
              'page not found!',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
