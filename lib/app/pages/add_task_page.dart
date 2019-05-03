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

const SlowStr = "不紧急";
const NormalStr = "正常";
const ImportStr = "重要";
const VeryImportStr = "非常重要";

class AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescController = TextEditingController();

  final taskNameFocusNode = FocusNode();
  final taskDescFocusNode = FocusNode();

  final Map<String, Color> _priorityTags = {
    SlowStr: Color(0xFF50D2C2),
    NormalStr: Color(0xFF14D4F4),
    ImportStr: Color(0xFFFF9400),
    VeryImportStr: Color(0xFFE53B3B),
  };

  String _dateTime = "请选择日期";
  String _beginTime = "请选择起始时间";
  String _endTime = "请选择终止时间";

  String _priorityValue;
  Color _priorityColor;

  final GlobalKey _priorityContainerKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _priorityValue = SlowStr;
    _priorityColor = _priorityTags[SlowStr];
    _taskNameController.addListener(() {});
  }

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
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: <Widget>[
              _createInputTextLine('名称', '任务名称', taskNameFocusNode,
                  maxLines: 1, controller: _taskNameController),
              _createInputTextLine('描述', '任务描述', taskDescFocusNode,
                  controller: _taskDescController),
              _createDatePicker(context, '日期'),
              _createTimeSelector(context, '起始时间', '终止时间'),
              _createPriorityWidget(context),
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
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            color: Colors.black26,
            height: 0.5,
          )
        ],
      ),
    );
  }

  Widget _createDatePicker(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Color(0xFF1D1D26), fontFamily: 'Avenir', fontSize: 14.0),
          ),
          GestureDetector(
            onTap: () async {
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day - 1),
                lastDate: DateTime(2025),
              );
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 35,
              child: Text(
                _dateTime,
                style: TextStyle(
                  color: Color.fromARGB(127, 0, 0, 0),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            color: Colors.black26,
            height: 0.5,
          )
        ],
      ),
    );
  }

  Widget _createTimeSelector(
      BuildContext context, String beginText, String endText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: _createSelectedTimeWidget(context, beginText,
              (TimeOfDay timeOfData) {
            _beginTime = timeOfData.toString();
          }),
        ),
        Expanded(
          child: _createSelectedTimeWidget(context, endText,
              (TimeOfDay timeOfData) {
            _endTime = timeOfData.toString();
          }),
        ),
      ],
    );
  }

  Widget _createSelectedTimeWidget(
      BuildContext context, String title, void setStateAction(TimeOfDay _)) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Color(0xFF1D1D26), fontFamily: 'Avenir', fontSize: 14.0),
          ),
          GestureDetector(
            onTap: () async {
              TimeOfDay timeOfDay = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              setState(() {
                setStateAction(timeOfDay);
              });
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 35,
              child: Text(
                _dateTime,
                style: TextStyle(
                  color: Color.fromARGB(127, 0, 0, 0),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            color: Colors.black26,
            height: 0.5,
          )
        ],
      ),
    );
  }

  Widget _createPriorityWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '优先级',
            style: TextStyle(
                color: Color(0xFF1D1D26), fontFamily: 'Avenir', fontSize: 14.0),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(_priorityValue),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    String priorityStr = await showMenu(
                        context: context,
                        position: buttonMenuPosition(context),
//    position: RelativeRect.fromLTRB(1000.0, 1000.0, 0.0, 10.0),
                        items: <PopupMenuItem<String>>[
                          _createPopMenuItemWidget(
                              SlowStr, _priorityTags[SlowStr]),
                          _createPopMenuItemWidget(
                              NormalStr, _priorityTags[NormalStr]),
                          _createPopMenuItemWidget(
                              ImportStr, _priorityTags[ImportStr]),
                          _createPopMenuItemWidget(
                              VeryImportStr, _priorityTags[VeryImportStr]),
                        ]);
                    if (priorityStr == null) return;
                    this.setState(() {
                      _priorityValue = priorityStr;
                      _priorityColor = _priorityTags[priorityStr];
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: Container(
                      key: _priorityContainerKey,
                      width: 100,
                      height: 5,
                      color: _priorityColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            color: Colors.black26,
            height: 0.5,
          )
        ],
      ),
    );
  }

  Widget _createPopMenuItemWidget(String title, Color color) {
    return PopupMenuItem<String>(
      value: title,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(title),
          Container(
            width: 100,
            height: 5,
            color: color,
          )
        ],
      ),
    );
  }

  RelativeRect buttonMenuPosition(BuildContext c) {
    final RenderBox renderBox =
        _priorityContainerKey.currentContext.findRenderObject();
//    final positionRed = renderBox.localToGlobal(Offset.zero);

    final RenderBox overlay = Overlay.of(c).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        renderBox.localToGlobal(
            Offset(renderBox.size.width, renderBox.size.height),
            ancestor: overlay),
        renderBox.localToGlobal(
            Offset(renderBox.size.width, renderBox.size.height),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    return position;
  }
}
