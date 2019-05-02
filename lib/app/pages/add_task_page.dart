import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddTaskPageState();
  }
}

typedef TextChangeFunc = void Function(String);

typedef TextComplete = void Function();

class AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescController = TextEditingController();

  final taskNameFocusNode = FocusNode();
  final taskDescFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ADD TASK',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            print('on tap');
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: <Widget>[
              _createInputTextLine('名称', '任务名称', taskNameFocusNode,
                  maxLines: 1, controller: _taskNameController),
              _createInputTextLine('描述', '任务描述', taskDescFocusNode,
                  controller: _taskDescController)
            ],
          ),
        ),
      ),
      resizeToAvoidBottomPadding: false, //输入框抵住键盘
    );
  }

  Widget _createInputTextLine(
      String title, String hintText, FocusNode focusNode,
      {int maxLines, TextEditingController controller}) {
    TextInputType inputType =
        maxLines == null ? TextInputType.multiline : TextInputType.text;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Color(0xFF1D1D26), fontFamily: 'Avenir', fontSize: 14.0),
          ),
          TextField(
            keyboardType: inputType,
            textInputAction: TextInputAction.done,
            focusNode: focusNode,
            maxLines: maxLines,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            color: Colors.black26,
            height: 1,
          )
        ],
      ),
    );
  }
}
