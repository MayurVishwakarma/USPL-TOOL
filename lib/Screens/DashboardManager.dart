// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uspltool/Provider/DashbordProvider.dart';
import 'package:uspltool/Widgets/custom_appbar.dart';
import 'package:uspltool/utils/color_manager.dart';

class DashboardManager extends StatefulWidget {
  static const routeName = "/DashboardManager";
  DashboardManager({super.key});

  @override
  State<DashboardManager> createState() => _DashboardManagerState();
}

class _DashboardManagerState extends State<DashboardManager> {
  final key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final dpr = Provider.of<DashboardProvider>(context);
    return Scaffold(
      key: key,
      appBar: CustomAppBar(scaffoldKey: key, title: dpr.appbar[dpr.pageIndex]),
      body: dpr.screens[dpr.pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 15,
        showUnselectedLabels: true,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.white,
        currentIndex: dpr.pageIndex,
        onTap: (value) => dpr.updatePageIndex(value),
        items: [
          BottomNavigationBarItem(
            backgroundColor: ColorManager.balck255,
            icon: SvgPicture.asset(
              'assets/images/user-listcom.svg',
              height: 25,
              color: dpr.pageIndex == 0 ? Colors.deepOrange : Colors.white,
            ),
            label: 'User List',
          ),
          BottomNavigationBarItem(
            backgroundColor: ColorManager.balck255,
            icon: Icon(
              Icons.list,
            ),
            label: 'Daily Login',
          ),
          BottomNavigationBarItem(
            backgroundColor: ColorManager.balck255,
            icon: SvgPicture.asset(
              'assets/images/portfolio.svg',
              color: dpr.pageIndex == 2 ? Colors.deepOrange : Colors.white,
            ),
            label: 'Trade',
          ),
          BottomNavigationBarItem(
            backgroundColor: ColorManager.balck255,
            icon: SvgPicture.asset(
              'assets/images/line-chart.svg',
              color: dpr.pageIndex == 3 ? Colors.deepOrange : Colors.white,
            ),
            label: 'Tracker',
          ),
          BottomNavigationBarItem(
            backgroundColor: ColorManager.balck255,
            icon: SvgPicture.asset(
              'assets/images/logs.svg',
              color: dpr.pageIndex == 4 ? Colors.deepOrange : Colors.white,
            ),
            label: 'Log',
          ),
          BottomNavigationBarItem(
            backgroundColor: ColorManager.balck255,
            icon: SvgPicture.asset(
              'assets/images/wishlist.svg',
              height: 20,
              color: dpr.pageIndex == 5 ? Colors.deepOrange : Colors.white,
            ),
            label: 'Equity',
          ),
        ],
      ),
    );
  }
}
