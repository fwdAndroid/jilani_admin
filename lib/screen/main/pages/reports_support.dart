import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jilani_admin/screen/tab/complains.dart';
import 'package:jilani_admin/screen/tab/helpdesk.dart';
import 'package:jilani_admin/utils/color.dart';

class ReportsSupport extends StatefulWidget {
  const ReportsSupport({super.key});

  @override
  State<ReportsSupport> createState() => _ReportsSupportState();
}

class _ReportsSupportState extends State<ReportsSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                labelSpacing: 60,
                radius: 100,
                contentCenter: true,
                width: 120,
                height: 50,
                backgroundColor: mainColor,
                unselectedLabelStyle: TextStyle(color: black),
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: GoogleFonts.inter().fontFamily),
                tabs: [
                  Tab(
                    text: "Complains",
                  ),
                  Tab(
                    text: "Help Desk",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Complains(),
                    HelpDesk(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
