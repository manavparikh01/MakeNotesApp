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

  uncompleted(String id) {
    setState(() {
      val = id;
      complete = 0;
    });
    Future.delayed(Duration(seconds: 2), () {
      Provider.of<ToTask>(context, listen: false).uncompleteTask(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task added again'),
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  color: Color.fromRGBO(34, 56, 29, 0.2),
                  constraints: BoxConstraints(
                    minHeight: 200,
                    maxHeight: 450,
                    maxWidth: MediaQuery.of(context).size.width,
                    minWidth: 100,
                  ),
                  child: FutureBuilder(
                    future:
                        Provider.of<ToTask>(context, listen: false).fetchData(),
                    builder: (ctx, snapshot) => snapshot.connectionState ==
                            ConnectionState.waiting
                        ? Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Consumer<ToTask>(
                            child: Center(
                              child: Text('No tasks added yet'),
                            ),
                            builder: (ctx, toTask, ch) => toTask.items.length <=
                                    0
                                ? ch
                                : ListView.builder(
                                    itemCount: toTask.items.length,
                                    itemBuilder: (ctx, i) {
                                      final item = toTask.items[i].id;
                                      final itemTitle = toTask.items[i].title;
                                      var time = toTask.items[i].time;
                                      var datetime = DateTime.parse(time);
                                      var date =
                                          "${datetime.day}-${datetime.month}";
                                      return Container(
                                        // width:
                                        //     MediaQuery.of(context).size.width,
                                        // width: 200,
                                        // width:
                                        //     MediaQuery.of(context).size.width -
                                        //         10,
                                        // constraints: BoxConstraints(
                                        //     maxWidth: 300,
                                        //     maxHeight: 30,
                                        //     minWidth: 100,
                                        //     minHeight: 30),
                                        color: Color.fromRGBO(0, 255, 0, 0.3),
                                        margin: EdgeInsets.only(
                                            top: 5,
                                            left: 10,
                                            right: 10,
                                            bottom: 0),
                                        child:
                                            // SingleChildScrollView(
                                            //   child:
                                            //   Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceBetween,
                                            // children: <Widget>[
                                            ListTile(
                                          leading: Radio(
                                            activeColor: Colors.grey,
                                            autofocus: true,
                                            focusColor: Colors.grey,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            groupValue: null,
                                            onChanged: (value) {
                                              Future.delayed(
                                                  Duration(milliseconds: 500),
                                                  () {
                                                toTask.items[i]
                                                    .isCompletedToggle();
                                                completed(value);
                                              });
                                            },
                                            value: item,
                                          ),
                                          title:
                                              //    item == val &&
                                              //         complete == 1
                                              //     ? null
                                              // ? Text(
                                              //     itemTitle,
                                              //     style: TextStyle(
                                              //         color: Colors.grey,
                                              //         decoration:
                                              //             TextDecoration.lineThrough),
                                              // )
                                              //:
                                              Text(itemTitle),
                                          subtitle: Text(
                                            date,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                        //   Container(
                                        //     width: 20,
                                        //     child: Icon(Icons.delete),
                                        //   ),
                                        // ],
                                        // ),
                                        //),
                                      );
                                    },
                                  ),
                          ),
                  ),
                ),
              ),
              Container(
                child: Text('Completed Tasks'),
              ),
              SingleChildScrollView(
                child: Container(
                  height: 200,
                  color: Color.fromRGBO(45, 23, 54, 0.3),
                  constraints: BoxConstraints(),
                  child: Consumer<ToTask>(
                    child: Center(
                      child: Text('No Tasks Completed Today'),
                    ),
                    builder: (ctx, toTask, ch) => toTask.completed.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: toTask.completed.length,
                            itemBuilder: (ctx, i) {
                              final item = toTask.completed[i].id;
                              final itemTitle = toTask.completed[i].title;
                              var time = toTask.completed[i].time;
                              var datetime = DateTime.parse(time);
                              var date = "${datetime.day}-${datetime.month}";
                              return Container(
                                color: Color.fromRGBO(0, 0, 255, 0.3),
                                margin: EdgeInsets.only(
                                    top: 5, left: 10, right: 10, bottom: 0),
                                child: ListTile(
                                  leading: Radio(
                                    activeColor: Colors.grey,
                                    autofocus: true,
                                    focusColor: Colors.grey,
                                    fillColor:
                                        MaterialStateProperty.all(Colors.grey),
                                    groupValue: null,
                                    onChanged: (value) {
                                      Future.delayed(
                                          Duration(milliseconds: 500), () {
                                        toTask.items[i].isCompletedToggle();
                                        uncompleted(value);
                                      });
                                    },
                                    value: item,
                                  ),
                                  title: //item == val && complete == 1
                                      //?
                                      Text(
                                    itemTitle,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  //: null,
                                  subtitle: Text(
                                    date,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              );
                            }),
                  ),
                ),
              ),
            ],
          ),
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
