import 'package:blog_app/const_values.dart';
import 'package:blog_app/models/posts.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Refresh extends StatefulWidget {
  final String? text;
  final VoidCallback? onPressed;

  Refresh({this.text, this.onPressed});

  @override
  _RefreshState createState() => _RefreshState();
}

class _RefreshState extends State<Refresh> {
  @override
  Widget build(BuildContext context) {
    //final Posts changeData = Hive.box(appState).get('state');
    return TextButton(
      onPressed: widget.onPressed,
      child: Text(
        '${widget.text}',
        style: TextStyle(
          color: defaultWhite,
        ),
      ),
    );
  }
}
