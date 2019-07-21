import 'package:flutter/material.dart';
import 'package:todo_list/app/data/task_status.dart';
import 'package:todo_list/app/data/todo_task.dart';
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
  int _finishedTaskCount = 64;
  int _handlingTaskCount = 32;
  int _delayedTaskCount = 12;
  List<TodoTask> _tasks = [
    TodoTask(title: "和御姐去锻炼身体"),
    TodoTask(title: "和至于讨论dart特性"),
    TodoTask(title: "Tast3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
            child: ScrollOptionView(
              options: months,
            )
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  _buildAllTaskStatusArea(),
                  _buildColouredStripeArea(),
                  Expanded(child: _buildTaskListArea(), flex: 1),
                ],
              ),
            )
          )
        ],
      )
    );
  }

  Widget _buildAllTaskStatusArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildTaskStatusView(TaskStatus.finished, _finishedTaskCount),
        _buildTaskStatusView(TaskStatus.handling, _handlingTaskCount),
        _buildTaskStatusView(TaskStatus.delay, _delayedTaskCount),
      ],
    );
  }

  Widget _buildColouredStripeArea() {
    int sum = _finishedTaskCount + _handlingTaskCount + _delayedTaskCount;
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildColouredStripe(_finishedTaskCount / sum, const Color(0xff51d2c2)),
          _buildColouredStripe(_handlingTaskCount / sum, const Color(0xff8c88ff)),
          _buildColouredStripe(_delayedTaskCount / sum, const Color(0xffffb258)),
        ],
      )
    );
  }

  Widget _buildTaskListArea() {
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        TodoTask task = _tasks[index];
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(color: task.status.color, height: 10, width: 10, margin: EdgeInsets.all(10),),
                Text(task.title),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.access_time, size: 15, color: Color(0xffb9b9bc),),
                  Text(' ${task.fromTime.hour} - ${task.toTime.hour}', style: TextStyle(color: Color(0xffb9b9bc))),
                ],
              ),
            ),
            Container(height: 1, color: Color(0xffececed), margin: EdgeInsets.fromLTRB(0, 20, 0, 20),)
          ],
        );
      }
    );
  }

  Widget _buildColouredStripe(double percentage, Color color) {
    return SizedBox(
      height: 10,
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: percentage,
        child: DecoratedBox(decoration: BoxDecoration(color: color),),
      ),
    );
  }

  Widget _buildTaskStatusView(TaskStatus status, int count) {
    if (status == null) {
      status = TaskStatus.handling;
    }
    return Column(
      children: <Widget>[
        Text(status.description, style: TextStyle(fontSize: 16)),
        Text(count.toString(), style: TextStyle(fontSize: 33)),
        Container(color: status.color, height: 10, width: 10, margin: EdgeInsets.all(10),)
      ],
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
