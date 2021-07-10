import 'package:flutter/material.dart';
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
    {'screen': NotePageRises(), 'title': 'NotePage'},
    {'screen': ToDoTask(), 'title': 'Tasks'}
  ];

  int selected = 0;

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
            icon: Icon(Icons.notes),
            title: Text('NotePage'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tab),
            title: Text('Tasks'),
          ),
        ],
      ),
    );
  }
}
