import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:jilani_admin/screen/tab/approved.dart';
import 'package:jilani_admin/screen/tab/declined.dart';
import 'package:jilani_admin/screen/tab/pending.dart';
import 'package:jilani_admin/utils/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
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
                    text: "Pending",
                  ),
                  Tab(
                    text: "Approved",
                  ),
                  Tab(
                    text: "Declined",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[Pending(), Approved(), Declined()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
