import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:makemynotes/provider/provider.dart';
import 'package:makemynotes/views/addPage.dart';
import 'package:provider/provider.dart';
//import 'showPageOne.dart';
import 'showPage.dart';

class NotePage extends StatefulWidget {
  static const routeName = '/notePage';

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool _pinned = false;
  bool _snap = false;
  bool _floating = true;

  // deleteNote(String item, String itemTitle) {
  //   return AlertDialog(
  //     //title: ,
  //     content: Text('Delete $itemTitle'),
  //     actions: [
  //       TextButton(
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         },
  //         child: Text('Cancel'),
  //       ),
  //       TextButton(
  //         onPressed: () {
  //           Provider.of<TakeNote>(context, listen: false).deleteNote(item);
  //           print('snak');
  //           ScaffoldMessenger.of(context)
  //               .showSnackBar(SnackBar(content: Text('$itemTitle deleted')));
  //           print('bar');
  //         },
  //         child: Text('Delete'),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final note = Provider.of<TakeNote>(context, listen: false);
    return Scaffold(
        // appBar: SliverAppBar(
        //   centerTitle: Text('All Notes'),

        // ),
        // AppBar(
        //   title: Text('NotesApp'),
        //   actions: [
        //     IconButton(
        //         icon: Icon(Icons.add),
        //         onPressed: () {
        //           //Navigator.of(context).pushNamed(AddPage.routeName);
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => AddPage()));
        //         })
        //   ],
        // ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //Navigator.of(context).pushNamed(AddPage.routeName);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddPage()));
          },
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              expandedHeight: 160.0,
              centerTitle: true,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text('All Notes'),
                background: FlutterLogo(),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Container(
                  height: 500,
                  width: double.infinity,
                  child:

                      // SliverList(
                      //   delegate: SliverChildBuilderDelegate(
                      //     (BuildContext context, int index) {
                      //       return Container(
                      //         color: index.isOdd ? Colors.white : Colors.black12,
                      //         height: 100.0,
                      //         child: Center(
                      //           child: Text('$index', textScaleFactor: 5),
                      //         ),
                      //       );
                      //     },
                      //     childCount: 20,
                      //   ),
                      // ),

                      FutureBuilder(
                    future: Provider.of<TakeNote>(context, listen: false)
                        .fetchData(),
                    builder: (ctx, snapshot) => snapshot.connectionState ==
                            ConnectionState.waiting
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Consumer<TakeNote>(
                            child: Center(child: Text('No notes yet')),
                            builder: (ctx, takeNote, ch) => takeNote
                                        .items.length <=
                                    0
                                ? ch
                                : ListView.builder(
                                    itemCount: takeNote.items.length,
                                    itemBuilder: (ctx, i) {
                                      final item = takeNote.items[i].id;
                                      final itemTitle = takeNote.items[i].title;
                                      return Dismissible(
                                        key: Key(item),
                                        //direction: DismissDirection.endToStart,
                                        confirmDismiss: (direction) {
                                          return showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              //title: Text('Are you sure?'),
                                              content:
                                                  Text('Delete $itemTitle'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx)
                                                        .pop(false);
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
                                          //  return AlertDialog(
                                          //   //title: ,
                                          //   content: Text('Delete $itemTitle'),
                                          //   actions: [
                                          //     TextButton(
                                          //       onPressed: () {
                                          //         Navigator.of(context).pop(false);
                                          //       },
                                          //       child: Text('Cancel'),
                                          //     ),
                                          //     TextButton(
                                          //       onPressed: () {
                                          //         Provider.of<TakeNote>(context,
                                          //                 listen: false)
                                          //             .deleteNote(item);
                                          //         print('snak');
                                          //         ScaffoldMessenger.of(context)
                                          //             .showSnackBar(SnackBar(
                                          //                 content:
                                          //                     Text('$itemTitle deleted')));
                                          //                     Navigator.of(context).pop(true);
                                          //         print('bar');
                                          //       },
                                          //       child: Text('Delete'),
                                          //     ),
                                          //   ],
                                          // );
                                          // print('sfdwfsavcfsqsdac');
                                          // ScaffoldMessenger.of(context).showSnackBar(
                                          //   SnackBar(
                                          //     content: Container(
                                          //       child: Column(
                                          //         children: <Widget>[
                                          //           Text('Do you want to delete this note'),
                                          //           Container(
                                          //             child: Row(
                                          //               children: <Widget>[
                                          //                 TextButton(
                                          //                   onPressed: () {
                                          //                     Navigator.of(context).pop();
                                          //                   },
                                          //                   child: Text('Cancel'),
                                          //                 ),
                                          //                 TextButton(
                                          //                   onPressed: () {
                                          //                     Provider.of<TakeNote>(context,
                                          //                             listen: false)
                                          //                         .deleteNote(item);
                                          //                     print('snak');
                                          //                     ScaffoldMessenger.of(context)
                                          //                         .showSnackBar(SnackBar(
                                          //                             content: Text(
                                          //                                 '$itemTitle deleted')));
                                          //                     print('bar');
                                          //                   },
                                          //                   child: Text('Delete'),
                                          //                 ),
                                          //               ],
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ),
                                        },
                                        dragStartBehavior:
                                            DragStartBehavior.down,
                                        onDismissed: (direction) {
                                          Provider.of<TakeNote>(context,
                                                  listen: false)
                                              .deleteNote(item);
                                          print('snak');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      '$itemTitle deleted')));
                                        },
                                        background: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
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
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black54),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 7),
                                          child: ListTile(
                                            title:
                                                Text(takeNote.items[i].title),
                                            subtitle:
                                                takeNote.items[i].text.length >=
                                                        20
                                                    ? Text(
                                                        '${takeNote.items[i].text.substring(0, 20)}...',
                                                        maxLines: 1,
                                                      )
                                                    : Text(
                                                        '${takeNote.items[i].text}',
                                                        maxLines: 1,
                                                      ),
                                            onTap: () {
                                              // Navigator.of(context).pushNamed(
                                              //     ShowPage.routeName,
                                              //     arguments: takeNote.items[i].id);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ShowPage(
                                                              id: takeNote
                                                                  .items[i]
                                                                  .id)));
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
