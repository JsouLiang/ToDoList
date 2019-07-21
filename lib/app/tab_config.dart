
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'main_hub_page.dart';
import 'pages/overview_page.dart';
import 'pages/task_page.dart';
import 'pages/todo_list_page.dart';

/// 这里放置的首页的 Tab 配置
final List<TabConfig> mainHubPageTabs = [
  TabConfig(imagePath: 'assets/images/calendar.png', page: TodoListPage()),
  TabConfig(imagePath: 'assets/images/group.png', page: OverviewPage()),
  TabConfig(
    navigationBarItem: BottomNavigationBarItem(
      icon: Image(
        image: AssetImage('assets/images/add.png'),
        width: 50,
        height: 50,
      ),
      title: Text('')
    ),
    page: TaskPage(pageType: TaskPageType.add),
    onTap: (context, tabConfig) {
      Navigator.of(context).push(PageRouteBuilder(pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => TaskPage(pageType: TaskPageType.add)));
      return false;
    }
  ),
  TabConfig(imagePath: 'assets/images/lists.png', page: TodoListPage()),
  TabConfig(imagePath: 'assets/images/completed.png', page: TodoListPage()),
];
