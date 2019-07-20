import 'package:flutter/material.dart';
import 'package:todo_list/app/data/app_state.dart';
import 'package:todo_list/app/main_hub_page.dart';

import 'app/colors.dart';

void main() => runApp(ToDoListApp());

class ToDoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppStateContainer(
      appState: AppState(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: primaryColor,
          indicatorColor: indicatorColor,
          accentColor: accentColor,
        ),
        home: MainHubPage(),
      ),
    );
  }
}

