import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';

class Task with ChangeNotifier {
  final String id;
  final String title;
  final String time;
  bool isCompleted;

  Task({
    @required this.id,
    @required this.title,
    @required this.time,
    this.isCompleted = false,
  });

  void isCompletedToggle() {
    isCompleted = !isCompleted;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'isCompleted': isCompleted,
    };
  }
}
