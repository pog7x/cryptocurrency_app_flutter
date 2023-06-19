import 'package:flutter/material.dart';

const lightColor = Color.fromARGB(255, 245, 240, 235);
const darkColor = Color.fromARGB(255, 31, 31, 31);

final lightTheme = ThemeData(
  primarySwatch: Colors.yellow,
  scaffoldBackgroundColor: darkColor,
  dividerTheme: const DividerThemeData(
    color: lightColor,
    indent: 10,
    endIndent: 10,
    thickness: .3,
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: lightColor,
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
