import 'package:flutter/cupertino.dart';

import 'dart:ui';
import '../model/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../helper/sqlStoreTasks.dart';

class ToTask with ChangeNotifier {
  List<Task> _items = [];

  List<Task> get items {
    return _items.where((task) => task.isCompleted == 'false').toList();
  }

  List<Task> get completed {
    return _items.where((task) => task.isCompleted == 'true').toList();
  }

  Task findById(String id) {
    return _items.firstWhere((task) => task.id == id);
  }

  void addTask(String title) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      time: DateTime.now().toString(),
      isCompleted: 'false',
    );
    _items.add(newTask);
    notifyListeners();

    SqlStore.insert('user_tasks', {
      'id': newTask.id,
      'title': newTask.title,
      'time': newTask.time,
      'isCompleted': newTask.isCompleted,
    });
  }

  void completeTask(String id) {
    var existingNoteIndex = _items.indexWhere((prod) => prod.id == id);
    var existingNote = _items[existingNoteIndex];
    final updatedNote = Task(
        id: id,
        title: existingNote.title,
        time: existingNote.time,
        isCompleted: 'true');
    if (existingNoteIndex != null) {
      _items[existingNoteIndex] = updatedNote;
      SqlStore.update(
        'user_tasks',
        updatedNote,
      );
      notifyListeners();
      print('coo');
    }
    print('coooo');
  }

  void uncompleteTask(String id) {
    var existingNoteIndex = _items.indexWhere((prod) => prod.id == id);
    var existingNote = _items[existingNoteIndex];
    final updatedNote = Task(
        id: id,
        title: existingNote.title,
        time: existingNote.time,
        isCompleted: 'false');
    if (existingNoteIndex != null) {
      _items[existingNoteIndex] = updatedNote;
      SqlStore.update(
        'user_tasks',
        updatedNote,
      );
      notifyListeners();
      print('coo');
    }
    print('coooo');
  }

  void deleteTask(String id) {
    var existingNoteIndex = _items.indexWhere((prod) => prod.id == id);
    var existingNote = _items[existingNoteIndex];
    if (existingNote != null && existingNoteIndex != null) {
      _items.removeWhere((prod) => prod.id == id);
      SqlStore.delete(
        'user_tasks',
        id = existingNote.id,
      );
      notifyListeners();
    }
  }

  Future<void> fetchData() async {
    final dataset = await SqlStore.getData('user_tasks');
    _items = dataset
        .map((item) => Task(
            id: item['id'],
            title: item['title'],
            time: item['time'],
            isCompleted: item['isCompleted']))
        .toList();
    notifyListeners();
  }
}
