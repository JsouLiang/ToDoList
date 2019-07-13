import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/data/todo_task.dart';

const Color DOING_TASK_COLOR = Color.fromARGB(255, 80, 210, 194);
const Color LATER_TASK_COLOR = Color.fromARGB(255, 255, 51, 102);

typedef TaskCallBack = void Function(TodoTask task);
typedef ConfirmAction = Future<bool> Function(DismissDirection direction, TodoTask task);

class TaskItem extends StatefulWidget {
  final TodoTask task;
  final Animation<double> animation;
  final canOption;
  TaskCallBack onFinished;
  TaskCallBack onImported;
  TaskCallBack onDelete;
  ConfirmAction confirmDismissCallback;
  TaskItem({
    Key key,
    @required this.task,
    @required this.animation,
    this.onFinished,
    this.onImported,
    this.onDelete,
    this.canOption = true,
    this.confirmDismissCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TaskItemState();
  }
}

//
class TaskItemState extends State<TaskItem> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 246), vsync: this);

    setState(() {});

    _animation = CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 1.0, curve: Curves.linear),
    );
  }

  void _move(DragUpdateDetails details) {
    final double delta = details.primaryDelta / 304;
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _controller.value += delta;
        break;
      case TextDirection.ltr:
        _controller.value -= delta;
        break;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    bool _isFlingGesture = -details.velocity.pixelsPerSecond.dx > 700;

    if (_isFlingGesture) {
      final double flingVelocity = details.velocity.pixelsPerSecond.dx;
      _controller.fling(velocity: flingVelocity.abs() * 0.003333);
    } else if (_controller.value < 0.4) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

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
                task.finished ? 'assets/images/rect_selected.png' : 'assets/images/rect.png',
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
            child: Image.asset(task.import ? 'assets/images/Star.png' : 'assets/images/Star_Normal.png'),
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

    Widget actionBtn(Color bgColor, Icon icon) {
      return Container(
          height: 100,
          decoration: BoxDecoration(
            color: bgColor,
            border: Border(
              top: BorderSide(style: BorderStyle.solid, color: Colors.black12),
              bottom: BorderSide(style: BorderStyle.solid, color: Colors.black12),
            ),
          ),
          child: IconButton(
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 24.0, right: 24.0),
            icon: icon,
            color: Color(0xFFFFFFFF),
            onPressed: () {},
          ));
    }

    Widget content = Container(
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
    );

    if (widget.canOption) {
      return Dismissible(
        key: Key(task.id),
        direction: DismissDirection.endToStart,
        onDismissed: (directiom) {
          widget.onDelete(task);
        },
        confirmDismiss: (direction) async {
          bool result = await widget.confirmDismissCallback(direction, task);
          return result;
        },
        child: SizeTransition(
          sizeFactor: widget.animation,
          child: content,
        ),
        background: Container(
          padding: const EdgeInsets.only(right: 10),
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "删除",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Icon(
                Icons.delete,
                color: Colors.white,
              )
            ],
          ),
        ),
      );
    } else {
      return content;
    }
  }

//    return SizeTransition(
//      sizeFactor: widget.animation,
//      child: GestureDetector(
//        onHorizontalDragUpdate: _move,
//        onHorizontalDragEnd: _handleDragEnd,
//        child: Stack(
//          children: <Widget>[
//            Positioned.fill(
//              right: 10,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.end,
//                children: <Widget>[
//                  actionBtn(Colors.black54, Icon(Icons.edit)),
//                  actionBtn(Color(0xFFE57373), Icon(Icons.delete)),
//                ],
//              ),
//            ),
//            SlideTransition(
//              position: new Tween<Offset>(
//                begin: Offset.zero,
//                end: const Offset(-0.4, 0.0),
//              ).animate(_animation),
//              child: Container(
//                key: Key(task.id),
//                decoration: BoxDecoration(
//                  color: Colors.white,
//                  border: Border(
//                    left: BorderSide(width: 2, color: DOING_TASK_COLOR),
//                  ),
//                ),
//                height: 110.0,
//                margin: const EdgeInsets.all(10.0),
//                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[taskInfoRow, timeRow],
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );

//    PositionedDirectional

//    return SizeTransition(
//      sizeFactor: widget.animation,
////    return FadeTransition(
////      opacity: widget.animation,
////    return PositionedTransition(
//////      rect: ,
////    return SlideTransition(
////      position: Tween(
////              begin: Offset.zero,
////              end: Offset(widget.animation.value, widget.animation.value))
////          .animate(widget.animation),
//      child:
//      Container(
//        key: Key(task.id),
//        decoration: BoxDecoration(
//          color: Colors.white,
//          border: Border(
//            left: BorderSide(width: 2, color: DOING_TASK_COLOR),
//          ),
//        ),
//        height: 110.0,
//        margin: const EdgeInsets.all(10.0),
//        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[taskInfoRow, timeRow],
//        ),
//      ),
//    );
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
