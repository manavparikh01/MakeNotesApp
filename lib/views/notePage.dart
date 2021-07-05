import 'package:flutter/material.dart';
import 'package:makemynotes/provider/provider.dart';
import 'package:makemynotes/views/addPage.dart';
import 'package:provider/provider.dart';
import './showPage.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    final note = Provider.of<TakeNote>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('NotesApp'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPage()));
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPage()));
        },
      ),
      body: FutureBuilder(
        future: Provider.of<TakeNote>(context, listen: false).fetchData(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<TakeNote>(
                child: Center(child: Text('No notes yet')),
                builder: (ctx, takeNote, ch) => takeNote.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: takeNote.items.length,
                        itemBuilder: (ctx, i) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                          ),
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                          child: ListTile(
                            title: Text(takeNote.items[i].title),
                            subtitle: Text(takeNote.items[i].text),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowPage()));
                            },
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
