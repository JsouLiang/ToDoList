import 'package:flutter/material.dart';
import 'package:todo_list/app/data/app_state.dart';
import 'package:todo_list/app/main_hub_page.dart';

void main() => runApp(ToDoListApp());

class ToDoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppStateContainer(
      appState: AppState.loading(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(ThemeColor),
          indicatorColor: Colors.white,
          accentColor: Color(ThemeColor),
        ),
        home: MainHubPage(),
      ),
    );
  }
}

const int ThemeColor = 0xFF50D2C2;

//class ToDoListApp extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return ToDoListAppStatus();
//  }
//}

//class ToDoListAppStatus extends State<ToDoListApp> {
//  @override
//  Widget build(BuildContext context) {
//    return
//  }
//}
