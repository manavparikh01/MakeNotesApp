//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:makemynotes/provider/provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ShowPage extends StatelessWidget {
  final String id;
  ShowPage({this.id});
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  Future<void> _updateNote(BuildContext context) async {
    if (id != null) {
      await Provider.of<TakeNote>(context, listen: false)
          .updateNote(id, _titleController.text, _noteController.text);
    }
    print('co');

    //Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final selectedNote =
        Provider.of<TakeNote>(context, listen: false).findById(id);
    _titleController.text = selectedNote.title;
    _noteController.text = selectedNote.text;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: selectedNote.title,
                ),
                controller: _titleController,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              //height: 300,
              child: TextField(
                decoration: InputDecoration(hintText: selectedNote.text),
                controller: _noteController,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
                child: Text('Update Note'),
                onPressed: () {
                  _updateNote(context = context);
                  //Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}
