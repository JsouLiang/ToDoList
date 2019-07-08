import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/app/components/message_dialog.dart';
import 'package:todo_list/app/components/task_item.dart';
import 'package:todo_list/app/data/app_state.dart';
import 'package:todo_list/app/data/data_base.dart';
import 'package:todo_list/app/data/task_list_page_model.dart';
import 'package:todo_list/app/data/todo_task.dart';
import 'package:todo_list/app/pages/login_page.dart';

class TodoListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

const Color DOING_TASK_COLOR = Color.fromARGB(255, 80, 210, 194);
const Color LATER_TASK_COLOR = Color.fromARGB(255, 255, 51, 102);

class TodoListState extends State<TodoListPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  TaskListPageModel<TodoTask> _list;

  List<TodoTask> tasks = [];
  Set<String> selectedTask = Set();

  int _lastStarIndex = 0;
  AppState appState;
  DataBase _dataBase;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    _hadLogined();
  }

  _hadLogined() async {
    String email = await _savedEmail();
    if (email == null) {
      /// 弹窗登录页面
      email = await Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
              LoginPage(),
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return SlideTransition(
              position: Tween(begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0)).animate(animation),
              child: child,
            );
          }));
    }
    if (_dataBase == null || appState.email != email) {
      _dataBase = DataBase(userName: email);
    }
    List<TodoTask> tasks = await _dataBase.data();
    setState(() {
      appState.email = email;
      this.tasks = tasks;
      _loading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (appState == null) {
      appState = AppStateContainer.of(context);
    }
  }

  Widget _getBody() {
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      _list = TaskListPageModel(listKey: _listKey, initialItems: tasks, removedItemBuilder: _buildRow);

      return AnimatedList(
          key: _listKey,
          initialItemCount: tasks.length,
          itemBuilder: (context, index, animation) {
            if (index < 0 || index >= tasks.length) {
              return null;
            }
            return _buildRow(index, context, animation);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
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

  void _finished(TodoTask task) {
//    task.finished = !task.finished;
//    if (task.finished) {
//      _list.remove(task);
//      _list.insert(_list.length, task);
//    }

    task.finished = !task.finished;
    if (task.finished) {
      animatedRemove(task);
      animatedInsert(task, index: tasks.length);
    }

    setState(() {
//      task.finished = !task.finished;
//      if (task.finished) {
//        tasks.remove(task);
//        tasks.add(task);
//      }
    });
  }

  AnimatedListState get _animatedList => _listKey.currentState;

  void _star(TodoTask task) {
    task.import = !task.import;
    _list.remove(task);
    if (task.import) {
      _list.insert(0, task);
      _lastStarIndex++;
    } else {
      _list.insert(--_lastStarIndex, task);
    }
  }

  void _delete(TodoTask task) {
    final index = tasks.indexOf(task);
    tasks.remove(task);
    setState(() {});
//    _animatedList.removeItem(index);
    animatedRemove(task);
  }

  void animatedInsert(TodoTask task, {int index = 0}) {
    tasks.insert(index, task);
    _animatedList.insertItem(index);
  }

  void animatedRemove(TodoTask task) {
    final int index = tasks.indexOf(task);
    tasks.remove(task);
    _animatedList.removeItem(index, (context, animation) {
      return _buildRow(index, context, animation, canOption: false);
    });
  }

  Future<String> _savedEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("Email");
  }

  Future<String> _savedPassword(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(email);
  }

  Widget _buildRow(int index, BuildContext context, Animation animation, {bool canOption = true}) {
    if (index >= tasks.length) {
      return null;
    }
    TodoTask task = tasks[index];
    return TaskItem(
      task: task,
      animation: animation,
      onFinished: _finished,
      onImported: _star,
      onDelete: _delete,
      canOption: canOption,
    );
  }
}
