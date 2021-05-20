import 'package:flutter/cupertino.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';

class Note {
  final String id;
  final String title;
  final String text;

  Note({
    @required this.id,
    @required this.title,
    @required this.text,
  });
}
