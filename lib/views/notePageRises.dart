import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:makemynotes/provider/provider.dart';
import 'package:makemynotes/views/addPage.dart';
import 'package:provider/provider.dart';
//import 'showPageOne.dart';
import 'showPage.dart';

class NotePageRises extends StatefulWidget {
  //const NotePageRises({ Key? key }) : super(key: key);

  @override
  _NotePageRisesState createState() => _NotePageRisesState();
}

class _NotePageRisesState extends State<NotePageRises> {
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
              backgroundColor: Colors.white,
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              elevation: 0,
              expandedHeight: 212.0,
              // centerTitle: false,
              // title: Text(
              //   'All notes',
              //   style: TextStyle(color: Colors.black),
              // ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                //titlePadding: EdgeInsets.only(),
                background: Container(
                  child: Stack(
                    children: [
                      Image.asset('assets/notes.jpg'),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              'All Notes',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // background: Image.network(
                //     'https://www.google.com/imgres?imgurl=https%3A%2F%2Fakm-img-a-in.tosshub.com%2Findiatoday%2Fimages%2Fstory%2F201912%2Fpost-it-notes-1284667_960_720.jpeg%3FgR6sVQyc4bC7CXp.HHR2uFzTilSyqiBP%26size%3D770%3A433&imgrefurl=https%3A%2F%2Fwww.indiatoday.in%2Finformation%2Fstory%2Fhow-to-send-google-keep-note-to-another-app-using-computer-1628978-2019-12-17&tbnid=2nli-ParvZ3ytM&vet=12ahUKEwi986KRrtXxAhUSRysKHbQdBI0QMygeegUIARCTAg..i&docid=Yoggz_UzKKqe3M&w=770&h=433&q=notes&ved=2ahUKEwi986KRrtXxAhUSRysKHbQdBI0QMygeegUIARCTAg'),
                // background: Image.network(
                //      'https://github.com/flutter/plugins/raw/master/packages/video_player/video_player/doc/demo_ipod.gif?raw=true'),
                stretchModes: [StretchMode.blurBackground],
                // title: Text(
                //   'All Notes',
                //   style: TextStyle(color: Colors.black),
                // ),
                // centerTitle: true,
              ),
            ),
            // SliverToBoxAdapter(
            //   child: SingleChildScrollView(
            //     child: Container(
            //       height: 500,
            //       width: double.infinity,
            //       child:

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
              future: Provider.of<TakeNote>(context, listen: false).fetchData(),
              builder: (ctx, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Container(
                          height: 500,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    )
                  : Consumer<TakeNote>(
                      child: SliverToBoxAdapter(
                        child: Container(
                          height: MediaQuery.of(context).size.height - 230,
                          child: Center(
                            child: Text('No notes yet'),
                          ),
                        ),
                      ),
                      builder: (ctx, takeNote, ch) => takeNote.items.length <= 0
                          ? ch
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (ctx, i) {
                                  //itemCount: takeNote.items.length,
                                  // itemBuilder: (ctx, i) {
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
                                    dragStartBehavior: DragStartBehavior.down,
                                    onDismissed: (direction) {
                                      Provider.of<TakeNote>(context,
                                              listen: false)
                                          .deleteNote(item);
                                      print('snak');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('$itemTitle deleted')));
                                    },
                                    background: Container(
                                      width: MediaQuery.of(context).size.width -
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
                                        border:
                                            Border.all(color: Colors.black54),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 7),
                                      child: ListTile(
                                        title: Text(takeNote.items[i].title),
                                        subtitle:
                                            takeNote.items[i].text.length >= 20
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
                                                              .items[i].id)));
                                        },
                                      ),
                                    ),
                                  );
                                },
                                childCount: takeNote.items.length,
                              ),
                            ),
                    ),
            ),
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
