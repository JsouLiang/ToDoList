import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'tab_config.dart';

class MainHubPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainHubPageState();
  }
}

class MainHubPageState extends State<MainHubPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<TabConfig> tabs = mainHubPageTabs.takeWhile((tab) => tab.page != null).toList();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: IndexedStack(
          index: _currentIndex,
          children: tabs.map((tab) => tab.page).toList()
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            bool canSwitch = true;
            final tab = tabs[index];
            if (tab.onTap != null) {
              canSwitch = tab.onTap(context, tab);
            }
            if (canSwitch) {
              this.setState(() {
                _currentIndex = index;
              });
            }
          },
          currentIndex: _currentIndex,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          items: tabs.map((tab) => _buildBottomNavigationBarItem(tab)).toList(),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(TabConfig tab) {
    if (tab == null) {
      return null;
    }
    if (tab.navigationBarItem != null) {
      return tab.navigationBarItem;
    }

    return BottomNavigationBarItem(
      activeIcon: ImageIcon(AssetImage(tab.imagePath), size: 24, color: activeTabColor),
      icon: ImageIcon(AssetImage(tab.imagePath), size: 24, color: inactiveTabColor),
      title: Text(tab.title ?? '')
    );
  }
}

typedef TabOnTapCallback = bool Function(BuildContext context, TabConfig tabConfig);

class TabConfig {
  /// Tab 名字
  final String title;
  /// Tab 上显示的图片
  final String imagePath;
  /// 如果想设置自定义的 Widget，可以使用这个选项
  final BottomNavigationBarItem navigationBarItem;
  /// tab 对应的页面
  final Widget page;
  final TabOnTapCallback onTap;

  const TabConfig({
    this.title,
    this.imagePath,
    this.navigationBarItem,
    this.page,
    this.onTap,
  });
}