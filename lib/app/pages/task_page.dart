import 'package:flutter/material.dart';
import 'package:todo_list/app/data/priority.dart';
import 'package:todo_list/app/utils/location.dart';
import 'package:todo_list/app/utils/utils.dart';
import 'package:todo_list/app/widgets/widgets.dart';

class PriorityPopupMenuItem extends PopupMenuItem<int> {
  PriorityPopupMenuItem({Key key, Priority priority}):
    assert(priority != null),
    super(
      key: key,
      value: priority.value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(priority.description),
          Container(
            width: 100,
            height: 5,
            color: priority.color,
          )
        ],
      )
    );
}

class TaskPage extends StatefulWidget {

  final TaskPageType pageType;

  TaskPage({
    Key key,
    // 默认页面类型为 任务添加页面
    this.pageType = TaskPageType.add
  }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TaskPageState();
  }
}

/// 页面类型
enum TaskPageType {
  add,
  edit,
  view,
}

typedef TextChangeFunc = void Function(String);

typedef TextComplete = void Function();

class TaskPageState extends State<TaskPage> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescController = TextEditingController();

  final taskNameFocusNode = FocusNode();
  final taskDescFocusNode = FocusNode();

  Priority _priority = Priority.normal;

  TextEditingController _dateTextController;
  DateFieldController _dateController;
  TextEditingController _startTimeTextController;
  TimeFieldController _startTimeController;
  TextEditingController _endTimeTextController;
  TimeFieldController _endTimeController;
  TaskPageType _pageType = TaskPageType.view;

  final TextStyle _titleStyle = TextStyle(color: Color(0xFF1D1D26), fontFamily: 'Avenir', fontSize: 14.0);
  final EdgeInsetsGeometry _padding = const EdgeInsets.fromLTRB(20, 10, 20, 20);
  final InputBorder _border = UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26, width: 0.5));

  final GlobalKey _priorityContainerKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _pageType = widget.pageType;

    // Location.getCurrentLocation().then((value) {
    //   print('当前位置' + value);
    // });

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
      appBar: _buildAppBar(),
      body: _buildForm(),
      resizeToAvoidBottomPadding: false, //输入框抵住键盘
    );
  }

  /// 创建 AppBar
  Widget _buildAppBar() {
    return AppBar(
      // 设置 AppBar 的背景色为白色
      backgroundColor: Colors.white,
      // 创建取消按钮，该按钮被点击时会触发 _cancel() 函数
      leading: IconButton(icon: Icon(Icons.close, color: Color(0xffbbbbbe)), onPressed: _cancel,),
      // 设置页面标题
      title: Text(
        _pageTitle,
        style: TextStyle(color: Colors.black),
      ),
      // 创建确定按钮，该按钮被点击时会触发 _submit() 函数
      actions: <Widget>[IconButton(icon: Icon(Icons.check, color: Color(0xffbbbbbe)), onPressed: _submit)],
    );
  }

  /// 获取页面标题
  String get _pageTitle {
    switch (_pageType) {
      case TaskPageType.add:
        return '添加任务';
      case TaskPageType.edit:
        return '编辑任务';
      default:
        return '查看任务';
    }
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
            _buildPriorityWidget(),
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
        locale: Locale('zh', 'CN'),
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

  Widget _buildPriorityWidget() {
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
                  child: Text(_priority.description),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _showPriorityMenu,
                  child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: Container(
                      key: _priorityContainerKey,
                      width: 100,
                      height: 5,
                      color: _priority.color,
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

  _showPriorityMenu() async {
    /// 弹出优先级选择菜单
    int priority = await showMenu(
      context: context,
      position: _getMenuPosition(context),
      /// 将Priority的所有值列表映射为PriorityPopupMenuItem列表
      items: Priority.values.map((e) => _buildPriorityPopupMenuItem(e)).toList(),
    );
    if (priority == null) return;
    /// 将优先级值对应的Priority对象赋值给_priority
    this.setState(() {
      _priority = Priority(priority);
    });
  }

  PopupMenuItem<int> _buildPriorityPopupMenuItem(Priority priority) {
    return PopupMenuItem<int>(
      value: priority.value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(priority.description),
          Container(
            width: 100,
            height: 5,
            color: priority.color,
          )
        ],
      )
    );
  }

  RelativeRect _getMenuPosition(BuildContext c) {
    /// 获取优先级展示框的色块的Container对象锁对应的RenderBox对象
    final RenderBox renderBox = _priorityContainerKey.currentContext.findRenderObject();
    /// 获取当前上下文中图层对象
    final RenderBox overlay = Overlay.of(c).context.findRenderObject();
    /// 将色块的右下角的坐标转换为全局坐标
    final Offset startPoint = renderBox.localToGlobal(Offset(renderBox.size.width, renderBox.size.height), ancestor: overlay);
    /// 构造色块右下角位置所对应的RelativeRect对象
    return RelativeRect.fromSize(
      Rect.fromLTRB(startPoint.dx, startPoint.dy, startPoint.dx, startPoint.dy),
      overlay.size);
  }
}
