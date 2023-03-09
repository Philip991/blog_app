import 'package:blog_app/Home.dart';
import 'package:blog_app/const_values.dart';
import 'package:blog_app/screens/bookmark.dart';
import 'package:blog_app/screens/settings.dart';
import 'package:blog_app/widgets/search_bar_field.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TabView extends StatefulWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  bool _searchBoolean = false;
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    Home(),
    Bookmark(),
    Settings(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Box? storeData;

  @override
  void initState() {
    super.initState();
    storeData = Hive.box(appState);
  }

  Widget _searchTextField() {
    return SearchBarField();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: !_searchBoolean
            ? const Text(
                'As e dey hot',
              )
            : _searchTextField(),
        actions: !_searchBoolean
            ? [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _searchBoolean = true;
                    });
                  },
                ),
              ]
            : [
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchBoolean = false;
                    });
                  },
                )
              ],
      ),
      body: Center(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.purple,
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
      ),
    );
  }
}
