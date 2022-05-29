import 'package:availabuddy/core/essentials/textstyles.dart';
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
          title: Text('Availabuddy', style: AbTextStyles.black22w600),
        ),
        body: const Center(
            child: SizedBox(width: 500, height: 800, child: DateTimeTable())));
  }
}
