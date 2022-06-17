import 'package:availabuddy/pages/home/widgets/datetime_table.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: AppBar().preferredSize.height + 5,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                'assets/images/logo.png',
                height: 50,
              )),
        ),
        body: Center(
            child: Container(
                padding: const EdgeInsets.only(top: 10),
                width: 500,
                height: 800,
                child: const DateTimeTable())));
  }
}
