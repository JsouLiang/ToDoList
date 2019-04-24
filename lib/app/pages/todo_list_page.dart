import 'package:flutter/material.dart';

import '../components/profile_image_component.dart';
import 'user_grid_list_page.dart';

class TodoListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDoList'),
//        leading: Text(''),
        actions: <Widget>[
          ProfileImage(
            NetworkImage(
                'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3882265467,3924971696&fm=27&gp=0.jpg'),
            Size(kBottomNavigationBarHeight, kBottomNavigationBarHeight),
            onTapAction: () {
              Route route =
                  MaterialPageRoute(builder: (context) => UserGridListPage());
              Navigator.push(context, route);
            },
          ),
//          Container(
//            padding: const EdgeInsets.all(8.0),
//            child: IconButton(
//              icon: Icon(Icons.account_circle),
//              onPressed: () {
//
//              },
//            ),
//          )
        ],
      ),
      body: Center(
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemCount: 50,
            itemBuilder: (BuildContext context, int index) {
              return _buildRow();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Add",
        onPressed: () {},
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildRow() {
    Widget titleRow = Row(
      children: <Widget>[
        Checkbox(
          value: false,
          activeColor: Colors.red, //选中时的颜色
          onChanged: (value) {
            setState(() {
//              _checkboxSelected=value;
            });
          },
        ),
        Expanded(
          child: Text(
            '任务名称',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
          ),
        )
      ],
    );

    Widget timeRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          child: Text('19-4-2'),
        ),
        // 这是评论数，评论数由一个评论图标和具体的评论数构成，所以是一个Row组件
        Container(
          child: Row(
            // 为了让评论数显示在最右侧，所以需要外面的Expanded和这里的MainAxisAlignment.end
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(Icons.add_comment),
              Text("2"),
//              Image.asset('./images/ic_comment.png',
//                  width: 16.0, height: 16.0),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.star),
          onPressed: () {},
        )
      ],
    );

    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
            child: Column(
              children: <Widget>[
                titleRow,
                new Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: timeRow,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
