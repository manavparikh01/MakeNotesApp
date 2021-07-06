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

  Note findById(String id) {
    return _items.firstWhere((note) => note.id == id);
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

  showNote(String id) {
    var existingNoteIndex = _items.indexWhere((prod) => prod.id == id);
    var existingNote = _items[existingNoteIndex];
    if (existingNoteIndex != null && existingNote != null) {
      return Note(
        id: existingNote.id,
        title: existingNote.title,
        text: existingNote.text,
      );
    }
  }

  void updateNote(String id, String title, String text) {
    var existingNoteIndex = _items.indexWhere((prod) => prod.id == id);
    var existingNote = _items[existingNoteIndex];
    final updatedNote = Note(id: id, title: title, text: text);
    if (existingNoteIndex != null) {
      _items[existingNoteIndex] = updatedNote;
      SqlStore.update(
        'user_notes',
        updatedNote,
      );
      notifyListeners();
      print('coo');
    }
    print('coooo');
  }

  void deleteNote(String id) {
    var existingNoteIndex = _items.indexWhere((prod) => prod.id == id);
    var existingNote = _items[existingNoteIndex];
    if (existingNoteIndex != null && existingNote != null) {
      _items.removeWhere((prod) => prod.id == id);
      SqlStore.delete(
        'user_notes',
        id = existingNote.id,
      );
      notifyListeners();
    }
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
