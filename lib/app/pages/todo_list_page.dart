import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/components/message_dialog.dart';
import 'package:todo_list/app/components/task_item.dart';
import 'package:todo_list/app/data/task_list_page_model.dart';
import 'package:todo_list/app/data/todo_entry.dart';

class TodoListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

const Color DOING_TASK_COLOR = Color.fromARGB(255, 80, 210, 194);
const Color LATER_TASK_COLOR = Color.fromARGB(255, 255, 51, 102);

class TodoListState extends State<TodoListPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  TaskListPageModel<TodoEntry> _list;

  List<TodoEntry> tasks = [
    TodoEntry(title: "第一个任务", description: "第一个任务描述"),
    TodoEntry(title: "第二个任务", description: "第二个任务描述"),
    TodoEntry(title: "第三个任务", description: "第三个任务描述"),
    TodoEntry(title: "第四个任务", description: "第四个任务描述"),
    TodoEntry(title: "第五个任务", description: "第五个任务描述"),
    TodoEntry(title: "第六个任务", description: "第六个任务描述"),
    TodoEntry(title: "第七个任务", description: "第七个任务描述"),
    TodoEntry(title: "第八个任务", description: "第八个任务描述"),
    TodoEntry(title: "第九个任务", description: "第九个任务描述"),
    TodoEntry(title: "第十个任务", description: "第十个任务描述"),
  ];
  Set<String> selectedTask = Set();

  int _lastStarIndex = 0;

  @override
  void initState() {
    super.initState();

    _list = TaskListPageModel(
        listKey: _listKey, initialItems: tasks, removedItemBuilder: _buildRow);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YOUR LIST'),
        actions: <Widget>[],
      ),
      body: AnimatedList(
          key: _listKey,
          initialItemCount: _list.length,
          itemBuilder: (context, index, animation) {
            return _buildRow(_list[index], context, animation);
          }),
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

  void _finished(TodoEntry task) {
    task.finished = !task.finished;
    if (task.finished) {
      _list.remove(task);
      _list.insert(_list.length, task);
    }

    setState(() {
//      task.finished = !task.finished;
//      if (task.finished) {
//        tasks.remove(task);
//        tasks.add(task);
//      }
    });
  }

  void _star(TodoEntry task) {
    task.import = !task.import;
    _list.remove(task);
    if (task.import) {
      _list.insert(0, task);
      _lastStarIndex++;
    } else {
      _list.insert(--_lastStarIndex, task);
    }

    setState(() {
//      tasks.remove(task);
//      if (task.import) {
//        tasks.insert(0, task);
//        _lastStarIndex++;
//      } else {
//        tasks.insert(--_lastStarIndex, task);
//      }
    });
  }

  Widget _buildRow(TodoEntry task, BuildContext context, Animation animation) {
    return TaskItem(
      task: task,
      animation: animation,
      onFinished: _finished,
      onImported: _star,
    );
  }
}
