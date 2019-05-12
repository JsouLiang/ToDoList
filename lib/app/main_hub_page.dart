import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/pages/add_task_page.dart';
import 'package:todo_list/app/pages/todo_list_page.dart';

const int ThemeColor = 0xFF50D2C2;

class MainHubPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainHubPageState();
  }
}

class MainHubPageState extends State<MainHubPage>
    with SingleTickerProviderStateMixin {
  static List tabData = [
    {'icon': new Icon(Icons.language)},
    {'icon': new Icon(Icons.extension)},
    {'icon': new Icon(Icons.favorite)},
    {'icon': new Icon(Icons.import_contacts)}
  ];

  final List<Widget> _childPages = [
    TodoListPage(),
    TodoListPage(),
    AddTaskPage(),
    TodoListPage(),
    TodoListPage(),
  ];

  int _currentIndex = 0;
  Color _activeTabColor = Color(0xff50D2C2);
  Color _inactiveTabColor = Colors.black;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(ThemeColor),
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
        body: _childPages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTabChange,
          currentIndex: _currentIndex,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          items: [
            _buildBottomNavigationBarItem(
                imagePath: 'assets/images/calendar.png'),
            _buildBottomNavigationBarItem(imagePath: 'assets/images/group.png'),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('assets/images/add.png'),
                  width: 50,
                  height: 50,
                ), //ImageIcon(AssetImage('assets/images/add.png'), size: 60, color: _activeTabColor),
                title: Text('')),
            _buildBottomNavigationBarItem(imagePath: 'assets/images/lists.png'),
            _buildBottomNavigationBarItem(
                imagePath: 'assets/images/completed.png'),
          ],
        ),
//        bottomNavigationBar: SafeArea(
//          child: Container(
//            height: 65.0,
//            child: TabBar(
//              indicatorWeight: 0.0,
//              controller: _tabController,
////              unselectedLabelColor: Colors.black26,
//              tabs: <Widget>[
//                Tab(
//                  icon: ImageIcon(AssetImage('assets/images/calendar.png')),
//                ),
//                Tab(
//                  icon: ImageIcon(AssetImage('assets/images/add.png')),
//                )
//              ],
//            ),
//          ),
//        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      {String title, @required String imagePath}) {
    return BottomNavigationBarItem(
        activeIcon:
            ImageIcon(AssetImage(imagePath), size: 24, color: _activeTabColor),
        icon: ImageIcon(AssetImage(imagePath),
            size: 24, color: _inactiveTabColor),
        title: Text(title ?? ''));
  }

  void _onTabChange(int index) {
    if (mounted) {
      this.setState(() {
        _currentIndex = index;
      });
    }
  }
}
