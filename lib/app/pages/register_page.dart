import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_list/app/main_hub_page.dart';

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
//    _image = null;
    final avatar = FlatButton(
      onPressed: () => {_getImage()},
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48,
        backgroundImage: _image == null
            ? AssetImage('assets/images/defaultAvatar.png')
            : FileImage(_image),
      ),
    );

    final userName = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emailController,
      decoration: InputDecoration(
        hintText: '用户名',
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

    final registerBtn = FlatButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MainHubPage()));
      },
      color: Color.fromRGBO(69, 202, 181, 1),
      child: Center(
        child: Text(
          '注册',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '注册',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  avatar,
                  Positioned(
                    right: 20,
                    top: 5,
                    child: GestureDetector(
                      onTap: () => _getImage(),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Color.fromARGB(255, 80, 210, 194)),
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(
                          '+',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
              child: userName,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
              child: email,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
              child: password,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
              child: Container(
                height: 60,
                child: registerBtn,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('已有账号',
                    style: TextStyle(color: Color.fromRGBO(184, 184, 187, 1))),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      '登录',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
