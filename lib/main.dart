import 'package:flutter/material.dart';
import 'package:todo_list/app/main_hubPage.dart';
import 'package:todo_list/app/pages/login.dart';

void main() => runApp(ToDoListApp());
const int ThemeColor = 0xFF50D2C2;

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
        indicatorColor: Colors.white,
//          textSelectionColor: Colors.white
        accentColor: Color(ThemeColor),
//        textTheme: TextTheme(
//          //设置Material的默认字体样式
//          body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0),
//        ),
//        iconTheme: IconThemeData(
//          color: Color(ThemeColor),
//          size: 35.0,
//        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: LoginPage(),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
}
