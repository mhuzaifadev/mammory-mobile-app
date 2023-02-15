import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:mammory_project/views/login/map_screen.dart';
import 'package:mammory_project/views/login/userprofile.dart';

import 'home.dart';
import 'Mainrepo/mainreport.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  Widget? _child;

  @override
  void initState() {
    _child = SearchPage();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3edf9),
      extendBody: true,
      body: _child,
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
              icon: Icons.map,
              backgroundColor: Color(0xff8440fa),
              extras: {"label": "Map"}),
          FluidNavBarIcon(
              icon: Icons.home,
              backgroundColor: Color(0xff8440fa),
              extras: {"label": "Home"}),
          FluidNavBarIcon(
              icon: Icons.list_alt,
              backgroundColor: Color(0xff8440fa),
              extras: {"label": "Report"}),
        ],
        onChange: _handleNavigationChange,
        style: FluidNavBarStyle(
            barBackgroundColor: Color(0xff8440fa),
            iconSelectedForegroundColor: Colors.white,
            iconUnselectedForegroundColor: Colors.white),
        scaleFactor: 1.5,
        defaultIndex: 1,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras!["label"],
          child: item,
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = MapScreen();
          break;
        case 1:
          _child = SearchPage();
          break;
        case 2:
          _child = MainRepo();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 1000),
        child: _child,
      );
    });
  }
}
