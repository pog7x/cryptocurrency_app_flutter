import 'package:flutter/material.dart';

const lightColor = Color.fromARGB(255, 245, 240, 235);
const darkColor = Color.fromARGB(255, 31, 31, 31);
const primarySwatch = Colors.yellow;
const activeColor = Colors.yellow;
const inactiveColor = Colors.grey;
const bottomNavBackground = Color.fromARGB(255, 21, 21, 21);

final lightTheme = ThemeData(
  primarySwatch: primarySwatch,
  scaffoldBackgroundColor: darkColor,
  unselectedWidgetColor: inactiveColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: bottomNavBackground,
    elevation: 0,
    unselectedIconTheme: IconThemeData(
      color: inactiveColor,
    ),
    selectedIconTheme: IconThemeData(
      color: activeColor,
    ),
    selectedItemColor: activeColor,
    unselectedItemColor: inactiveColor,
    selectedLabelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: lightColor,
    indent: 10,
    endIndent: 10,
    thickness: .3,
  ),
  iconTheme: const IconThemeData(
    color: activeColor,
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: activeColor,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: lightColor,
    ),
    backgroundColor: darkColor,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: lightColor,
    ),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: lightColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: lightColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: lightColor,
    ),
  ),
);
