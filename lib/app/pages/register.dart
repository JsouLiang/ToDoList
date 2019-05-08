import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_list/app/pages/todo_list_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<RegisterPage> {
  File _image;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      backgroundImage: AssetImage('images/flutter.png'),
    );

    final avatar = FlatButton(
      onPressed: () => {_getImage()},
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48,
        backgroundImage: _image == null
            ? AssetImage(
                'images/default.jpeg',
              )
            : FileImage(_image),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emailController,
      decoration: InputDecoration(
        hintText: '邮箱',
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
        hintText: '密码',
      ),
    );

    final cancelButon = FlatButton(
      onPressed: () => {Navigator.of(context).pop()},
      child: Column(
        children: <Widget>[
          Text('取消', style: TextStyle(color: Colors.black)),
        ],
      ),
    );

    final registerButton = FlatButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TodoListPage()));
      },
      child: Column(
        children: <Widget>[
          Text('注册', style: TextStyle(color: Colors.black)),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          logo,
          SizedBox(height: 10),
          Text('TodoList', style: TextStyle(fontSize: 24)),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('头像:', style: TextStyle(fontSize: 20)),
              avatar,
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: email,
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: password,
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              cancelButon,
              registerButton,
            ],
          )
        ],
      )),
    );
  }
}
