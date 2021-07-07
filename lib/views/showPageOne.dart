//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:makemynotes/provider/provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ShowPage extends StatefulWidget {
  static const routeName = '/showPage';
  final String id;
  ShowPage({this.id});

  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  var _titleController = TextEditingController();

  var _noteController = TextEditingController();

  Future<void> _updateNote(BuildContext context) async {
    if (widget.id != null) {
      await Provider.of<TakeNote>(context, listen: false)
          .updateNote(widget.id, _titleController.text, _noteController.text);
    }
    print('co');

    //Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    //final id = ModalRoute.of(context).settings.arguments as String;
    final selectedNote =
        Provider.of<TakeNote>(context, listen: false).findById(widget.id);
    // final intialTitle = selectedNote.title;
    // final initialText = selectedNote.text;
    _titleController.text = selectedNote.title;
    _noteController.text = selectedNote.text;
    final appBar = AppBar(
      title: Text('New Note'),
      actions: [
        Container(
          width: 100,
          child: Center(
            child: GestureDetector(
              child: Text('Save'),
              onTap: () {
                _updateNote(context);
              },
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top -
                      40,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextField(
                            decoration: InputDecoration(
                              //hintText: 'Title',
                              contentPadding:
                                  EdgeInsets.only(top: 2, bottom: 1),
                              // border: OutlineInputBorder(
                              //   borderSide:
                              //       BorderSide(color: Colors.transparent, width: 1),
                              // ),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 1),
                              ),
                            ),
                            controller: _titleController,
                            onChanged: (value) {
                              _titleController.text = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          //height: 300,
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            minLines: 1,
                            maxLines: 300,
                            decoration: InputDecoration(
                              //hintText: 'Enter Note',
                              border: InputBorder.none,
                            ),
                            controller: _noteController,
                            onChanged: (value) {
                              _noteController.text = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              RaisedButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Text('Update Note'),
                  onPressed: () {
                    _updateNote(context);
                    //Navigator.of(context).pop();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
