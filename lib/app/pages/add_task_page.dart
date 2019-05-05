import 'package:flutter/material.dart';
import 'package:todo_list/app/utils/utils.dart';
import 'package:todo_list/app/widgets/widgets.dart';

class AddTaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
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

  String _priorityValue;
  Color _priorityColor;

  TextEditingController _dateTextController;
  DateFieldController _dateController;
  TextEditingController _startTimeTextController;
  TimeFieldController _startTimeController;
  TextEditingController _endTimeTextController;
  TimeFieldController _endTimeController;


  final TextStyle _titleStyle = TextStyle(color: Color(0xFF1D1D26), fontFamily: 'Avenir', fontSize: 14.0);
  final EdgeInsetsGeometry _padding = const EdgeInsets.fromLTRB(20, 10, 20, 20);
  final InputBorder _border = UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26, width: 0.5));

  final GlobalKey _priorityContainerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _priorityValue = SlowStr;
    _priorityColor = _priorityTags[SlowStr];

    _dateTextController = TextEditingController();
    _dateController = DateFieldController();
    _dateController.addListener(() {
      _dateTextController.text = DateTimeFormatter.formatChineseDate(_dateController.date);
    });

    _startTimeTextController = TextEditingController();
    _startTimeController = TimeFieldController();
    _startTimeController.addListener(() {
      _startTimeTextController.text = _startTimeController.time?.format(context);
    });

    _endTimeTextController = TextEditingController();
    _endTimeController = TimeFieldController();
    _endTimeController.addListener(() {
      _endTimeTextController.text = _endTimeController.time?.format(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.close, color: Color(0xffbbbbbe)), onPressed: _cancel,),
        title: Text(
          '添加任务',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[IconButton(icon: Icon(Icons.check, color: Color(0xffbbbbbe)), onPressed: _submit)],
      ),
      body: _buildForm(),
      resizeToAvoidBottomPadding: false, //输入框抵住键盘
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            _buildInputTextLine('名称', '任务名称', taskNameFocusNode,
                maxLines: 1, controller: _taskNameController),
            _buildInputTextLine('描述', '任务描述', taskDescFocusNode,
                controller: _taskDescController),
            _buildDatePicker('日期', '请选择日期', _dateController, _dateTextController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: _buildSelectedTimeWidget('起始时间', '请选择起始时间', _startTimeController, _startTimeTextController),
                ),
                Expanded(
                  child: _buildSelectedTimeWidget('终止时间', '请选择终止时间', _endTimeController, _endTimeTextController),
                ),
              ],
            ),
            _createPriorityWidget(context),
          ],
        ),
      ),
    );
  }

  void _submit() {
    // TODO: 
  }

  void _cancel() {
    // TODO:
  }

  Widget _buildInputTextLine(
      String title, String hintText, FocusNode focusNode,
      {int maxLines, TextEditingController controller}) {
    TextInputType inputType = maxLines == null ? TextInputType.multiline : TextInputType.text;
    return LabeledField(
      labelText: title,
      labelStyle: _titleStyle,
      padding: _padding,
      child: TextField(
        keyboardType: inputType,
        textInputAction: TextInputAction.done,
        focusNode: focusNode,
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: _border,
        ),
      ),
    );
  }

  Widget _buildDatePicker(String title, String hintText, DateFieldController dateController, TextEditingController textController) {
    return LabeledField(
      labelText: title,
      labelStyle: _titleStyle,
      padding: _padding,
      child: DateField(
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: hintText,
            disabledBorder: _border,
          ),
          enabled: false,
        ),
        controller: dateController,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day - 1),
        lastDate: DateTime(2025),
      ),
    );
  }

  Widget _buildSelectedTimeWidget(String title, String hintText, TimeFieldController timeController, TextEditingController textController) {
    return LabeledField(
      labelText: title,
      labelStyle: _titleStyle,
      padding: _padding,
      child: TimeField(
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: hintText,
            disabledBorder: _border,
          ),
          enabled: false,
        ),
        controller: timeController,
        initialTime: TimeOfDay.now(),
      ),
    );
  }

  Widget _createPriorityWidget(BuildContext context) {
    return LabeledField(
      labelText: '优先级',
      labelStyle: _titleStyle,
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
