import 'package:flutter/material.dart';
import 'package:todo_list/app/widgets/scroll_option_view.dart';

import '../colors.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

final List<String> months = [
  '1月',
  '2月',
  '3月',
  '4月',
  '5月',
  '6月',
  '7月',
  '8月',
  '9月',
  '10月',
  '11月',
  '12月',
];

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          Container(
            height: 70,
            child: ScrollOptionView(
              options: months,
            )
          )
        ],
      )
    );
  }

    /// 创建 AppBar
  Widget _buildAppBar() {
    return AppBar(
      // 设置 AppBar 的背景色为白色
      backgroundColor: backgroundColor,
      centerTitle: true,
      // 设置页面标题
      title: Text(
        '任务回顾',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}