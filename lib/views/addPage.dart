import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';

class AddPage extends StatefulWidget {
  static const routeName = '/addNote';

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  void _saveNote() {
    if (_noteController.text.isEmpty) {
      return;
    }
    Provider.of<TakeNote>(context, listen: false)
        .addNote(_titleController.text, _noteController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('New Note'),
      // actions: [
      //   Container(
      //     width: 100,
      //     child: Center(child),
      //   ),
      // ],
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
                      80,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Title',
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
                              hintText: 'Enter Note',
                              border: InputBorder.none,
                            ),
                            controller: _noteController,
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
              Container(
                height: 40,
                color: Color.fromRGBO(200, 34, 21, 0.4),
                child: Center(
                  child: Text('Colors'),
                ),
              ),
              RaisedButton(
                child: Text(
                  'Add note',
                ),
                color: _noteController.text.isNotEmpty
                    ? Colors.green
                    : Colors.grey,
                onPressed: _saveNote,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )
            ],
          ),
        ),
      ),
    );
  }
}
