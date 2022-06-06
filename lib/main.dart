import 'package:availabuddy/core/essentials/colors.dart';
import 'package:availabuddy/core/essentials/timezones.dart';
import 'package:availabuddy/pages/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  AbTimezoneHelper.initializeTimeZones();
  runApp(const Availabuddy());
}

class Availabuddy extends StatelessWidget {
  const Availabuddy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Availabuddy',
      theme: ThemeData(
        primarySwatch: AbColors.primarySwatch,
        brightness: Brightness.light,
        fontFamily: 'Gilroy',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: AbColors.black),
            backgroundColor: AbColors.scaffoldWhite,
            elevation: 0),
        scaffoldBackgroundColor: AbColors.scaffoldWhite,
      ),
      home: const HomeScreen(),
    );
  }
}
