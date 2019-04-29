import 'package:flutter/material.dart';
import 'package:todo_list/app/main_hubPage.dart';

void main() => runApp(ToDoListApp());
const int ThemeColor = 0xFFFFFFFF;

class ToDoListApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ToDoListAppStatus();
  }
}

class ToDoListAppStatus extends State<ToDoListApp>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(ThemeColor),
        backgroundColor: Color(0xFFEFEFEF),
        accentColor: Color(0xFF888888),
        textTheme: TextTheme(
          //设置Material的默认字体样式
          body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0),
        ),
        iconTheme: IconThemeData(
          color: Color(ThemeColor),
          size: 35.0,
        ),
      ),
      home: Scaffold(backgroundColor: Colors.white, body: MainHubPage()),
    );
  }
}
