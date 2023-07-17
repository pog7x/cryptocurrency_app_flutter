import 'package:flutter/material.dart';

const mainColorDark = Color.fromARGB(255, 31, 31, 31);
const secColorDark = Color.fromARGB(255, 245, 240, 235);
const primarySwatchDark = Colors.orange;
const activeColorDark = Colors.orange;
const inactiveColorDark = Colors.grey;
const bottomNavBackgroundDark = Color.fromARGB(255, 21, 21, 21);
const inputHintTextColorDark = Colors.white70;
const inputBackgroundDark = Color.fromARGB(255, 59, 58, 58);
const cardColorDark = Color.fromARGB(255, 21, 21, 21);

final darkTheme = ThemeData(
  cardColor: cardColorDark,
  disabledColor: inactiveColorDark,
  primarySwatch: primarySwatchDark,
  scaffoldBackgroundColor: mainColorDark,
  unselectedWidgetColor: inactiveColorDark,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: bottomNavBackgroundDark,
    elevation: 0,
    unselectedIconTheme: IconThemeData(
      color: inactiveColorDark,
    ),
    selectedIconTheme: IconThemeData(
      color: activeColorDark,
    ),
    selectedItemColor: activeColorDark,
    unselectedItemColor: inactiveColorDark,
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
    color: secColorDark,
    indent: 10,
    endIndent: 10,
    thickness: .3,
  ),
  iconTheme: const IconThemeData(
    color: activeColorDark,
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: activeColorDark,
    tileColor: mainColorDark,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: secColorDark,
    ),
    backgroundColor: mainColorDark,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: secColorDark,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    disabledBorder: OutlineInputBorder(),
    border: OutlineInputBorder(),
    filled: true,
    fillColor: inputBackgroundDark,
    hintStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: inputHintTextColorDark,
    ),
  ),
  hintColor: secColorDark,
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: secColorDark,
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: secColorDark,
    ),
    bodyLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: secColorDark,
    ),
    labelMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: secColorDark,
    ),
  ),
);
