import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/pages/todo_list_page.dart';

const int ThemeColor = 0xFFFFFFFF;

class MainHubPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainHubPageState();
  }
}

class MainHubPageState extends State<MainHubPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  static List tabData = [
    {'icon': new Icon(Icons.language)},
    {'icon': new Icon(Icons.extension)},
    {'icon': new Icon(Icons.favorite)},
    {'icon': new Icon(Icons.import_contacts)}
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 1, vsync: this);
  }

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
      home: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(controller: _tabController, children: [
          TodoListPage(),
        ]),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 65.0,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.deepPurpleAccent,
              unselectedLabelColor: Colors.black26,
              tabs: <Widget>[
                Tab(
                  icon: ImageIcon(AssetImage('assets/images/calendar.png')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
