import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';

class Task {
  final String id;
  final String title;
  final String time;

  Task({
    @required this.id,
    @required this.title,
    @required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'time': time,
    };
  }
}
