// ignore_for_file: unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uspltool/Provider/DashbordProvider.dart';
import 'package:uspltool/utils/color_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    required this.title,
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final dp = Provider.of<DashboardProvider>(context);
    return AppBar(
      backgroundColor: ColorManager.balck255,
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),

      // actions: [
      //   IconButton(
      //       onPressed: () {
      //         dp.showLogoutDialog(context);
      //       },
      //       icon: const Icon(Icons.logout))
      // ],
      leadingWidth: 45,
      // leading: Padding(
      //   padding: const EdgeInsets.all(4.0),
      //   child: CircleAvatar(
      //     backgroundColor: Colors.white,
      //     child: IconButton(
      //         onPressed: () {
      //           _scaffoldKey.currentState!.openDrawer();
      //         },
      //         icon: Image.asset(
      //           "assets/images/USPLLOGO.jpeg",
      //           height: 30,
      //         )),
      //   ),
      // ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
