import 'package:flutter/material.dart';
import 'package:pzz/theme.dart';
import 'package:pzz/ui/home_page.dart';

class PzzApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: pzzTheme,
      home: HomePage(),
    );
  }
}
