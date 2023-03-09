import 'package:flutter/material.dart';

class SearchBarField extends StatefulWidget {
  const SearchBarField({Key? key}) : super(key: key);

  @override
  _SearchBarFieldState createState() => _SearchBarFieldState();
}

class _SearchBarFieldState extends State<SearchBarField> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      autofocus: true,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }
}
