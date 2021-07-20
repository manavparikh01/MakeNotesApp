import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/taskProvider.dart';

class CompletedTask extends StatefulWidget {
  //const CompletedTask({ Key? key }) : super(key: key);

  @override
  _CompletedTaskState createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  bool onTapped = false;
  String val = '';

  onTappedFunction(String id) {
    setState(() {
      val = id;
      onTapped = !onTapped;
    });
  }

  uncompleted(String id) {
    // setState(() {
    //   val = id;
    //   complete = 0;
    // });
    Future.delayed(Duration(seconds: 2), () {
      Provider.of<ToTask>(context, listen: false).uncompleteTask(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task added again'),
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Task'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 40,
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
                            fillColor: MaterialStateProperty.all(Colors.grey),
                            groupValue: null,
                            onChanged: (value) {
                              setState(() {
                                onTappedFunction(value);
                              });
                              Future.delayed(Duration(milliseconds: 500), () {
                                //toTask.items[i].isCompletedToggle();
                                uncompleted(value);
                              });
                            },
                            value: item,
                          ),
                          title: //item == val && complete == 1
                              //?
                              onTapped && item == val
                                  ? Text(
                                      itemTitle,
                                      style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    )
                                  : Text(
                                      itemTitle,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough),
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
    );
  }
}
