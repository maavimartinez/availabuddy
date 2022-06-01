import 'package:availabuddy/pages/home/widgets/datetime_table.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Image.asset('assets/images/logo.png', width: 200),
        ),
        body: Center(
            child: Container(
                padding: const EdgeInsets.only(top: 20),
                width: 500,
                height: 800,
                child: const DateTimeTable())));
  }
}
