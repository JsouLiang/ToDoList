import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/pages/task_page.dart';
import 'package:todo_list/app/pages/todo_list_page.dart';

import 'colors.dart';

class MainHubPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainHubPageState();
  }
}

class MainHubPageState extends State<MainHubPage> with SingleTickerProviderStateMixin {
  static List tabData = [
    {'icon': new Icon(Icons.language)},
    {'icon': new Icon(Icons.extension)},
    {'icon': new Icon(Icons.favorite)},
    {'icon': new Icon(Icons.import_contacts)}
  ];
  final List<Widget> _childPages = [
    TodoListPage(),
//    TodoListPage(),
    TaskPage(),
//    TodoListPage(),
//    TodoListPage(),
  ];

  int _currentIndex = 0;
  Color _activeTabColor = Color(0xff50D2C2);
  Color _inactiveTabColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(themeColor),
        accentColor: Color(themeColor),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: _childPages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTabChange,
          currentIndex: _currentIndex,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          items: [
            _buildBottomNavigationBarItem(imagePath: 'assets/images/group.png'),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('assets/images/add.png'),
                  width: 50,
                  height: 50,
                ),
                title: Text('')),
            _buildBottomNavigationBarItem(imagePath: 'assets/images/lists.png'),
            _buildBottomNavigationBarItem(imagePath: 'assets/images/completed.png'),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({String title, @required String imagePath}) {
    return BottomNavigationBarItem(
        activeIcon: ImageIcon(AssetImage(imagePath), size: 24, color: _activeTabColor),
        icon: ImageIcon(AssetImage(imagePath), size: 24, color: _inactiveTabColor),
        title: Text(title ?? ''));
  }

  void _onTabChange(int index) {
    this.setState(() {
      _currentIndex = index;
    });
  }
}
