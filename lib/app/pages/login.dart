import 'package:flutter/material.dart';
import 'package:todo_list/app/pages/register.dart';
import 'package:todo_list/app/pages/todo_list_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // TODO: 用 list view 替换
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(100),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 48.0,
                child: Image.asset('assets/images/mark.png'),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Form(
                  key: Key('login'),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 24, right: 24),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          controller: emailController,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                            labelText: '邮箱',
                            hintText: '请输入邮箱',
                            labelStyle: TextStyle(color: Colors.black54),
                            hintStyle: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24, right: 24),
                        child: Stack(
                          children: <Widget>[
                            TextFormField(
                              autofocus: false,
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                                hintText: '请输入密码',
                                labelText: '密码',
                                labelStyle: TextStyle(color: Colors.black54),
                                hintStyle: TextStyle(color: Colors.black54),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              bottom: 0,
                              child: FlatButton(
                                onPressed: () => {},
                                child: Text('忘记密码?'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Container(
                    height: 60,
                    child: FlatButton(
                      onPressed: () {
                        print(emailController.text);
                        print(passwordController.text);
                        // TODO: 网络请求
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => TodoListPage()));
                      },
                      color: Color.fromRGBO(69, 202, 181, 1),
                      child: Center(
                        child: Text('登录', style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('还没有账号？', style: TextStyle(color: Color.fromRGBO(184, 184, 187, 1))),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => RegisterPage())),
                      child: Text('立即注册', style: TextStyle(
                        color: Colors.black,
                      )),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
