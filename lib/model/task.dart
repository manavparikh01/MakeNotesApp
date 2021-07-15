import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';

class Task with ChangeNotifier {
  final String id;
  final String title;
  final String time;
  String isCompleted;

  Task({
    @required this.id,
    @required this.title,
    @required this.time,
    this.isCompleted = 'false',
  });

  void isCompletedToggle() {
    if (isCompleted == 'false') {
      isCompleted = 'true';
    } else {
      isCompleted = 'false';
    }
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
