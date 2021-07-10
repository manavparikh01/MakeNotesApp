import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/taskProvider.dart';

class ToDoTask extends StatefulWidget {
  //const ToDoTask({ Key? key }) : super(key: key);

  @override
  _ToDoTaskState createState() => _ToDoTaskState();
}

class _ToDoTaskState extends State<ToDoTask> {
  final _noteController = TextEditingController();
  var complete = 0;
  var val;

  saveTask() {
    if (_noteController.text == null) {
      return;
    }
    Provider.of<ToTask>(context, listen: false).addTask(_noteController.text);
    setState(() {
      _noteController.text = '';
    });
    Navigator.of(context).pop();
  }

  completed(String id) {
    setState(() {
      val = id;
      complete = 1;
    });
    Future.delayed(Duration(seconds: 2), () {
      Provider.of<ToTask>(context, listen: false).completeTask(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task completed'),
        ),
      );
    });
  }

  bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            width: MediaQuery.of(context).size.width,
            //height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  color: Color.fromRGBO(0, 0, 255, 0.1),
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: 'I will go out today'),
                    controller: _noteController,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_upward,
                  ),
                  onPressed: saveTask,
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Consumer<ToTask>(
        child: Center(
          child: Text('No tasks added yet'),
        ),
        builder: (ctx, toTask, ch) => toTask.items.length <= 0
            ? ch
            : ListView.builder(
                itemCount: toTask.items.length,
                itemBuilder: (ctx, i) {
                  final item = toTask.items[i].id;
                  final itemTitle = toTask.items[i].title;
                  return Container(
                    child: ListTile(
                      leading: Radio(
                        groupValue: toTask,
                        onChanged: (value) {
                          completed(value);
                        },
                        value: item,
                      ),
                      title: item == val && complete == 1
                          ? Text(
                              'itemTitle',
                              style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            )
                          : Text(itemTitle),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 0, 0, 0.4),
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          bottomSheet();
        },
      ),
    );
  }
}
