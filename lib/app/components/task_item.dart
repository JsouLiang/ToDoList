import 'package:flutter/material.dart';
import 'package:todo_list/app/data/todo_entry.dart';

const Color DOING_TASK_COLOR = Color.fromARGB(255, 80, 210, 194);
const Color LATER_TASK_COLOR = Color.fromARGB(255, 255, 51, 102);

typedef TaskCallBack = void Function(TodoEntry task);

class TaskItem extends StatefulWidget {
  final TodoEntry task;
  final Animation<double> animation;
  TaskCallBack onFinished;
  TaskCallBack onImported;

  TaskItem(
      {Key key,
      @required this.task,
      @required this.animation,
      this.onFinished,
      this.onImported})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return TaskItemState();
  }
}

class TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    Widget taskInfoRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: () => widget.onFinished(task),
              child: Image.asset(
                task.finished
                    ? 'assets/images/rect_selected.png'
                    : 'assets/images/rect.png',
                width: 25.0,
                height: 25.0,
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                  task.title,
                  style: _descTitleStyle(task.finished),
                ))
          ],
        ),
        GestureDetector(
          onTap: () => widget.onImported(task),
          child: Container(
            child: Image.asset(task.import
                ? 'assets/images/Star.png'
                : 'assets/images/Star_Normal.png'),
            width: 25.0,
            height: 25.0,
          ),
        )
      ],
    );

    Widget timeRow = Row(
      children: <Widget>[
        Image.asset(
          'assets/images/group.png',
          width: 25.0,
          height: 25.0,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            "${task.getFromTimeStr().toString()} 至 ${task.getToTimeStr().toString()}",
            style: _descTitleStyle(task.finished),
          ),
        )
      ],
    );
    print(widget.animation);
//    PositionedDirectional
    return SizeTransition(
      sizeFactor: widget.animation,
//    return FadeTransition(
//      opacity: widget.animation,
//    return PositionedTransition(
////      rect: ,
      child: Container(
        key: Key(task.id),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 2, color: DOING_TASK_COLOR),
          ),
        ),
        height: 110.0,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[taskInfoRow, timeRow],
        ),
      ),
    );
  }

  TextStyle _descTitleStyle(bool selected) {
    return TextStyle(
      color: Color.fromARGB(255, 74, 74, 74),
      fontSize: 15,
      fontFamily: 'Avenir',
      decoration: selected ? TextDecoration.lineThrough : TextDecoration.none,
      decorationColor: Color.fromARGB(255, 74, 74, 74),
    );
  }
}
