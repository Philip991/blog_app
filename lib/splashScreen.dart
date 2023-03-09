import 'dart:async';

import 'package:blog_app/Home.dart';
import 'package:blog_app/const_values.dart';
import 'package:blog_app/screens/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  Box? storeData;
  @override
  void initState() {
    super.initState();
    storeData = Hive.box(appState);
    Timer(
        Duration(seconds: 3),
        () =>
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
              return const TabView();
            })));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/blog_logo2.jpg',
                height: 200,
                width: 200,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
