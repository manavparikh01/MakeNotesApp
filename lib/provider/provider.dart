import 'dart:io';
import 'package:flutter/foundation.dart';
import '../model/note.dart';

class TakeNote with ChangeNotifier {
  List<Note> _items = [];

  List<Note> get items {
    return [..._items];
  }
}
