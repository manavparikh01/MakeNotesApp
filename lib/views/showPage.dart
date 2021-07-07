//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:makemynotes/provider/provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ShowPage extends StatefulWidget {
  final String id;
  ShowPage({this.id});

  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  final _titleController = TextEditingController();

  final _noteController = TextEditingController();

  Future<void> _updateNote(BuildContext context) async {
    if (widget.id != null) {
      //if (userNote['title'].isEmpty)
      await Provider.of<TakeNote>(context, listen: false)
          //.updateNote(widget.id, userNote['title'], userNote['text']);
          .updateNote(widget.id, _titleController.text, _noteController.text);
    }
    print('co');

    //Navigator.of(context).pop();
  }

  Map<String, String> userNote = {
    'title': '',
    'text': '',
  };

  @override
  Widget build(BuildContext context) {
    final selectedNote =
        Provider.of<TakeNote>(context, listen: false).findById(widget.id);
    _titleController.text = selectedNote.title;
    _noteController.text = selectedNote.text;
    final appBar = AppBar(
      title: Text('Add Note'),
    );
    // final height = (MediaQuery.of(context).size.height -
    //     appBar.preferredSize.height -
    //     MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          // height: MediaQuery.of(context).size.height -
          //     appBar.preferredSize.height -
          //     MediaQuery.of(context).padding.top,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  height: 650,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: selectedNote.title,
                              border: InputBorder.none,
                            ),
                            controller: _titleController,
                            onChanged: (value) => {
                              userNote['title'] = value,
                              // _titleController.text = userNote['title'],
                              // setState(() {
                              //   _titleController.text = userNote['title'];
                              // })
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
                              hintText: selectedNote.text,
                              border: InputBorder.none,
                            ),
                            controller: _noteController,
                            onChanged: (value) => {
                              userNote['text'] = value,
                              // setState(() {
                              //   _noteController.text = userNote['text'];
                              // })
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
                  child: Text('Update Note'),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {
                    _updateNote(context = context);
                    //Navigator.of(context).pop();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
