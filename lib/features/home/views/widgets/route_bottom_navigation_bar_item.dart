import 'package:flutter/material.dart';

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  final String route;

  const MyCustomBottomNavBarItem(
      {required this.route,
        required super.icon,
        super.tooltip,
        super.label,
        Widget? activeIcon})
      : super(activeIcon: activeIcon ?? icon);
}