import 'package:flutter/material.dart';

class ThemeBuilder extends StatefulWidget {
  final Widget Function(
      BuildContext context, Brightness brightness, Color color) builder;
  final Brightness defaultBrightness;
  final Color color;

  ThemeBuilder({this.builder, this.defaultBrightness, this.color});

  @override
  _ThemeBuilderState createState() => _ThemeBuilderState();

  //static of(BuildContext context) {}

  static _ThemeBuilderState of(BuildContext context) {
    return context.findAncestorStateOfType<_ThemeBuilderState>();
  }
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  Brightness _brightness;
  Color _color;

  @override
  void initState() {
    super.initState();
    _brightness = widget.defaultBrightness;
    _color = widget.color;
    if (mounted) setState(() {});
  }

  void changeTheme() {
    setState(() {
      _color = Colors.amber;
    });
    setState(() {
      _brightness =
          _brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    });
  }

  Brightness getCurrentTheme() {
    return _brightness;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _brightness, _color);
  }
}
