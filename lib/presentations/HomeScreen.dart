import 'package:flutter/material.dart';
import 'package:reader/presentations/BookListScreen.dart';
import 'package:reader/presentations/DownloadingScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  final tabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(Icons.library_books), title: Text('Book')),
    BottomNavigationBarItem(
        icon: Icon(Icons.cloud_download), title: Text('Downloading')),
  ];

  Widget _renderBody() {
    switch (_selectedIndex) {
      case 0:
        return BookListScreen();
      case 1:
        return DownloadingScreen();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _renderBody(),
        bottomNavigationBar: BottomNavigationBar(
          items: tabs,
          currentIndex: _selectedIndex,
          fixedColor: Colors.deepPurple,
          onTap: _onItemTapped,
        ),
      );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
