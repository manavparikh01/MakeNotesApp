import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:makemynotes/controllers/themeBuilder.dart';
import 'package:makemynotes/provider/provider.dart';
import 'package:makemynotes/provider/taskProvider.dart';
import 'package:makemynotes/views/addPage.dart';
import 'package:makemynotes/views/bottomBar.dart';
import 'package:makemynotes/views/notePageRises.dart';
import 'package:makemynotes/views/showPageOne.dart';
import 'views/notePage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TakeNote(),
        ),
        ChangeNotifierProvider(
          create: (context) => ToTask(),
        ),
      ],

      //value: TakeNote(),
      child: ThemeBuilder(
          defaultBrightness: Brightness.light,
          builder: (context, _brightness, _color) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: _color,
                brightness: _brightness,
              ),
              home: BottomBar(),
              // initialRoute: NotePage.routeName,
              // routes: {
              //   ShowPage.routeName: (context) => ShowPage(),
              //   AddPage.routeName: (context) => AddPage(),
              // },
            );
          }),
    );
  }
}
