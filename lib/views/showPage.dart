import 'package:flutter/material.dart';

class ShowPage extends StatefulWidget {
  //const ShowPage();

  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

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
                decoration: InputDecoration(
                  hintText: 'hi',
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
                decoration: InputDecoration(labelText: 'Enter Note'),
                controller: _noteController,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
                child: Text('Update Note'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}
