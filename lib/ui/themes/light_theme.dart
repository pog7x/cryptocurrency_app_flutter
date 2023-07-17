import 'package:flutter/material.dart';

const mainColorLight = Color.fromARGB(255, 245, 240, 235);
const secColorLight = Color.fromARGB(255, 31, 31, 31);
const primarySwatchLight = Colors.purple;
const activeColorLight = Colors.purple;
const inactiveColorLight = Colors.grey;
const bottomNavBackgroundLight = Colors.white70;
const inputHintTextColorLight = Colors.black54;
const inputBackgroundLight = Color.fromARGB(255, 243, 243, 243);
const cardColorLight = Colors.white70;

final lightTheme = ThemeData(
  cardColor: cardColorLight,
  disabledColor: inactiveColorLight,
  primarySwatch: primarySwatchLight,
  scaffoldBackgroundColor: mainColorLight,
  unselectedWidgetColor: inactiveColorLight,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: bottomNavBackgroundLight,
    elevation: 0,
    unselectedIconTheme: IconThemeData(
      color: inactiveColorLight,
    ),
    selectedIconTheme: IconThemeData(
      color: activeColorLight,
    ),
    selectedItemColor: activeColorLight,
    unselectedItemColor: inactiveColorLight,
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
    color: secColorLight,
    indent: 10,
    endIndent: 10,
    thickness: .3,
  ),
  iconTheme: const IconThemeData(
    color: activeColorLight,
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: activeColorLight,
    tileColor: mainColorLight,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: secColorLight,
    ),
    backgroundColor: mainColorLight,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: secColorLight,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    disabledBorder: OutlineInputBorder(),
    border: OutlineInputBorder(),
    filled: true,
    fillColor: inputBackgroundLight,
    hintStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: inputHintTextColorLight,
    ),
  ),
  hintColor: secColorLight,
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: secColorLight,
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: secColorLight,
    ),
    bodyLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: secColorLight,
    ),
    labelMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: secColorLight,
    ),
  ),
);
