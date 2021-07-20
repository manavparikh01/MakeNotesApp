import 'package:flutter/material.dart';
import 'package:makemynotes/controllers/themeBuilder.dart';

class ThemePage extends StatefulWidget {
  //const ThemePage({ Key? key }) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Themes'),
      ),
      body: Container(
        child: Center(
          child: TextButton(
            child: Text('Change Theme'),
            onPressed: () {
              ThemeBuilder.of(context).changeTheme();
            },
          ),
        ),
      ),
    );
  }
}
