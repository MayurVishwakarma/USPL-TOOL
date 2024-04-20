// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uspltool/Provider/DashbordProvider.dart';
import 'package:provider/provider.dart';
import 'package:uspltool/Screens/DashboardManager.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late Timer _timer;
  @override
  void initState() {
    final dp = Provider.of<DashboardProvider>(context, listen: false);
    _timer = Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, DashboardManager.routeName);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/USPLLOGO.jpeg',
            height: 150,
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "version 1.0",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )
        ],
      )),
    );
  }
}
