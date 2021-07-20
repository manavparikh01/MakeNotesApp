import 'package:flutter/material.dart';
import 'package:makemynotes/views/datacollectionPage.dart';
import 'package:makemynotes/views/mainSettings.dart';
import 'package:makemynotes/views/notePage.dart';
import 'package:makemynotes/views/notePageRises.dart';
import 'package:makemynotes/views/toDoTask.dart';

class BottomBar extends StatefulWidget {
  //const BottomBar({ Key? key }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<Map<String, Object>> _pages = [
    {'screen': MainSettings(), 'title': 'SettingKinda'},
    {'screen': NotePageRises(), 'title': 'NotePage'},
    {'screen': ToDoTask(), 'title': 'Tasks'},
    {'screen': DataCollectionPage(), 'title': 'Overview'}
  ];

  int selected = 1;

  changeIndex(int index) {
    setState(() {
      selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selected]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        unselectedItemColor: Color.fromRGBO(0, 0, 0, 0.4),
        selectedItemColor: Color.fromRGBO(0, 0, 255, 0.4),
        type: BottomNavigationBarType.shifting,
        currentIndex: selected,
        onTap: changeIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text('Settings'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            title: Text('NotePage'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tab),
            title: Text('Tasks'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Tasks'),
          ),
        ],
      ),
    );
  }
}
