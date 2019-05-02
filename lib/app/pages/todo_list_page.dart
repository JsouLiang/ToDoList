import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/components/message_dialog.dart';

class TodoListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

const Color DOING_TASK_COLOR = Color.fromARGB(255, 80, 210, 194);
const Color LATER_TASK_COLOR = Color.fromARGB(255, 255, 51, 102);

class TodoListState extends State<TodoListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<List<int>> datas = [
      [1, 2],
      [1, 2, 3, 4],
      [1],
      [1, 2]
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YOUR LIST'),
//        leading: Text(''),
        actions: <Widget>[
//          ProfileImage(
//            NetworkImage(
//                'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3882265467,3924971696&fm=27&gp=0.jpg'),
//            Size(kBottomNavigationBarHeight, kBottomNavigationBarHeight),
//            onTapAction: () {
//              Route route =
//                  MaterialPageRoute(builder: (context) => UserGridListPage());
//              Navigator.push(context, route);
//            },
//              ),
        ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 248, 248, 248)),
          child:
              ListView.builder(itemBuilder: (BuildContext context, int index) {
            return _buildRow(index);
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Add",
        onPressed: () {
          showCupertinoDialog(
              context: context,
              builder: (BuildContext context) {
                return MessageDialog(
                  taskName: "Name",
                  taskTime: "Time",
                  taskDesc: "Task Desc",
                );
              });
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _avatarWidget(String assetURI) {
    return Image.asset(
      assetURI,
      width: 25.0,
      height: 25.0,
    );
  }

  TextStyle _descTitleStyle() {
    return TextStyle(
        color: Color.fromARGB(255, 74, 74, 74),
        fontSize: 14,
        fontFamily: 'Avenir');
  }

  Widget _buildRow(int index) {
    if (index == 50) return null;
    int avatarCount = 4;
    List<String> avatarURLs = [
      'assets/images/avatar.png',
      'assets/images/avatar.png',
      'assets/images/avatar.png',
      'assets/images/avatar.png'
    ];
    List<Widget> avatarWidgets = [];
    // 0 <= maxCount <= 3
    int maxCount = min(3, max(avatarURLs.length, 0));
    for (int index = 0; index < maxCount; ++index) {
      avatarWidgets.add(Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: _avatarWidget(avatarURLs[index]),
      ));
    }

    Widget titleRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset(
              'assets/images/group.png',
              width: 25.0,
              height: 25.0,
            ),
            Text(
              '15pm - 20pm',
              style: _descTitleStyle(),
            )
          ],
        ),
        Row(
          children: <Widget>[
            avatarCount > 3
                ? Text(
                    "+3",
                    style: _descTitleStyle(),
                  )
                : null,
            Row(children: avatarWidgets),
          ],
        )
      ],
    );

    Widget timeRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Dinner with Andrea',
          style: _descTitleStyle(),
        ),
        Container(
          child: Image.asset(
            'assets/images/Star.png',
            width: 25.0,
            height: 25.0,
          ),
        )
      ],
    );

    return Container(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 2, color: DOING_TASK_COLOR),
            )),
        height: 110.0,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[titleRow, timeRow],
        ),
      ),
    );
  }
}
