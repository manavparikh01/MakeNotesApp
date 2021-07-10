import 'package:flutter/cupertino.dart';

import 'dart:ui';
import '../model/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ToTask with ChangeNotifier {
  List<Task> _items = [];

  List<Task> get items {
    return _items;
  }

  Task findById(String id) {
    return _items.firstWhere((task) => task.id == id);
  }

  void addTask(String title) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      time: DateTime.now().toString(),
    );
    _items.add(newTask);
    notifyListeners();
  }

  void completeTask(String id) {
    var existingNoteIndex = _items.indexWhere((prod) => prod.id == id);
    var existingNote = _items[existingNoteIndex];
    if (existingNote != null && existingNoteIndex != null) {
      _items.removeWhere((prod) => prod.id == id);
    }
    notifyListeners();
  }
}
