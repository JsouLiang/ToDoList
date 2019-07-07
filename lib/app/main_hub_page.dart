import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/app/data/app_state.dart';
import 'package:todo_list/app/pages/add_task_page.dart';
import 'package:todo_list/app/pages/login_page.dart';
import 'package:todo_list/app/pages/todo_list_page.dart';

const int ThemeColor = 0xFF50D2C2;

class MainHubPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainHubPageState();
  }
}

enum PageState { Loading, UserLogined, NoUser }

class MainHubPageState extends State<MainHubPage> with SingleTickerProviderStateMixin {
  static List tabData = [
    {'icon': new Icon(Icons.language)},
    {'icon': new Icon(Icons.extension)},
    {'icon': new Icon(Icons.favorite)},
    {'icon': new Icon(Icons.import_contacts)}
  ];
  AppState appState;

  final List<Widget> _childPages = [
    TodoListPage(),
//    TodoListPage(),
    AddTaskPage(),
//    TodoListPage(),
//    TodoListPage(),
  ];

  int _currentIndex = 0;
  Color _activeTabColor = Color(0xff50D2C2);
  Color _inactiveTabColor = Colors.black;

  bool _logined = false;
  PageState _pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    _hadLogined();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (appState == null) {
      appState = AppStateContainer.of(context);
    }
  }

  _hadLogined() async {
    String email = await _savedEmail();
    if (email != null) {
      /// 获取本地数据
      setState(() {
        appState.email = email;
      });
    } else {
      /// 弹窗登录页面
      Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
              LoginPage(),
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return SlideTransition(
              position: Tween(begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0)).animate(animation),
              child: child,
            );
          }));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _getBody() {
    if (appState.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return _childPages[_currentIndex];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(ThemeColor),
        accentColor: Color(ThemeColor),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('YOUR LIST'),
          actions: <Widget>[],
        ),
        backgroundColor: Colors.white,
        body: _getBody(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTabChange,
          currentIndex: _currentIndex,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          items: [
//            _buildBottomNavigationBarItem(
//                imagePath: 'assets/images/calendar.png'),
            _buildBottomNavigationBarItem(imagePath: 'assets/images/group.png'),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('assets/images/add.png'),
                  width: 50,
                  height: 50,
                ), //ImageIcon(AssetImage('assets/images/add.png'), size: 60, color: _activeTabColor),
                title: Text('')),
            _buildBottomNavigationBarItem(imagePath: 'assets/images/lists.png'),
            _buildBottomNavigationBarItem(imagePath: 'assets/images/completed.png'),
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

  Future<String> _savedEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("Email");
  }

  Future<String> _savedPassword(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(email);
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({String title, @required String imagePath}) {
    return BottomNavigationBarItem(
        activeIcon: ImageIcon(AssetImage(imagePath), size: 24, color: _activeTabColor),
        icon: ImageIcon(AssetImage(imagePath), size: 24, color: _inactiveTabColor),
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
