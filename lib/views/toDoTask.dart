import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:makemynotes/views/completedTask.dart';
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 150,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // SingleChildScrollView(
              //   child: Container(
              //     color: Color.fromRGBO(34, 56, 29, 0.2),
              //     constraints: BoxConstraints(
              //       minHeight: 200,
              //       maxHeight: 450,
              //       maxWidth: MediaQuery.of(context).size.width,
              //       minWidth: 100,
              //     ),
              Expanded(
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
                          child: Container(
                            height: 500,
                            child: Center(
                              child: Text('No tasks added yet'),
                            ),
                          ),
                          builder: (ctx, toTask, ch) => toTask.items.length <= 0
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
                                    return Dismissible(
                                      key: Key(item),
                                      confirmDismiss: (direction) {
                                        return showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            //title: Text('Are you sure?'),
                                            content: Text('Delete $itemTitle'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(false);
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(true);
                                                },
                                                child: Text('Delete'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      dragStartBehavior: DragStartBehavior.down,
                                      onDismissed: (direction) {
                                        Provider.of<ToTask>(context,
                                                listen: false)
                                            .deleteTask(item);
                                        print('snak');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    '$itemTitle deleted')));
                                      },
                                      background: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                10,
                                        color: Colors.blue,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            // Icon(
                                            //   Icons.delete,
                                            //   color: Colors.white,
                                            //   size: 30,
                                            // ),
                                            // SizedBox(
                                            //   width: 20,
                                            // ),
                                            Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                      child: Container(
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
                                      ),
                                    );
                                  },
                                ),
                        ),
                ),
              ),

              Container(
                child: GestureDetector(
                  child: Text('See all Completed Tasks'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CompletedTask()),
                    );
                  },
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
