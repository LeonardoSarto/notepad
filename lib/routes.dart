import 'package:flutter/material.dart';
import 'package:my_notepad/pages/home.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> listRoutes = <String, WidgetBuilder>{
    "/home": (_) => Home(),
  };

  static const String home = "/home";
}