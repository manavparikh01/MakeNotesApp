import 'package:flutter/material.dart';
import 'package:makemynotes/views/themePage.dart';

class MainSettings extends StatefulWidget {
  //const MainSettings({ Key? key }) : super(key: key);

  @override
  _MainSettingsState createState() => _MainSettingsState();
}

class _MainSettingsState extends State<MainSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              color: Color.fromRGBO(0, 0, 255, 0.4),
              child: Center(
                child: Text('MakeNoteApp'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              child: ListTile(
                tileColor: Color.fromRGBO(0, 100, 255, 0.4),
                title: Text('Themes'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThemePage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
