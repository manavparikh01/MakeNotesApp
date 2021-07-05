import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  void _saveNote() {
    if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      return;
    }
    Provider.of<TakeNote>(context, listen: false)
        .addNote(_titleController.text, _noteController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
                decoration: InputDecoration(labelText: 'Title'),
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
                decoration: InputDecoration(labelText: 'Enter Note'),
                controller: _noteController,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(child: Text('Add note'), onPressed: _saveNote)
          ],
        ),
      ),
    );
  }
}
