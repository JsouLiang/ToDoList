import 'dart:ui';

import 'package:flutter/material.dart';

import '../components/profile_image_component.dart';

class UserGridListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserGridListPageState();
}

class UserGridListPageState extends State<UserGridListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text('ToDoList'),
//        leading: Text(''),
            actions: <Widget>[
              ProfileImage(
                NetworkImage(
                    'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3882265467,3924971696&fm=27&gp=0.jpg'),
                Size(kBottomNavigationBarHeight, kBottomNavigationBarHeight),
              )
            ],
          ),
          preferredSize: Size.fromHeight(kBottomNavigationBarHeight)),
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
//            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//              maxCrossAxisExtent: 100,
//              childAspectRatio: 1.0,
//              mainAxisSpacing: 10,
//              crossAxisSpacing: 10,
//            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              return _buildRow();
            }),
      )),
      floatingActionButton: FloatingActionButton(
        heroTag: "Add",
        onPressed: () {},
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildRow() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3882265467,3924971696&fm=27&gp=0.jpg'),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
