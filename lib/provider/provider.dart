import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../helper/sqlStore.dart';
import '../model/note.dart';

class TakeNote with ChangeNotifier {
  List<Note> _items = [];

  List<Note> get items {
    return [..._items];
  }

  void addNote(String title, String note) {
    final newNote = Note(
      id: DateTime.now().toString(),
      title: title,
      text: note,
    );
    _items.add(newNote);
    notifyListeners();

    SqlStore.insert('user_notes', {
      'id': newNote.id,
      'title': newNote.title,
      'text': newNote.text,
    });
  }

  Future<void> fetchData() async {
    final dataset = await SqlStore.getData('user_notes');
    _items = dataset
        .map((item) =>
            Note(id: item['id'], title: item['title'], text: item['text']))
        .toList();
    notifyListeners();
  }
}
