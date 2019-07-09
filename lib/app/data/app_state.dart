import 'package:flutter/widgets.dart';
import 'package:todo_list/app/data/todo_task.dart';

class AppState {
  String email;
  AppState({this.email});

  ValueNotifier<List<TodoTask>> tasks = ValueNotifier([]);

  @override
  String toString() {
    return 'AppState{email:}';
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final AppState data;
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);
  @override
  bool updateShouldNotify(_InheritedStateContainer oldWidget) {
    bool result = data != oldWidget.data;
    return result;
  }
}

class AppStateContainer extends StatefulWidget {
  final AppState appState;
  final Widget child;

  AppStateContainer({this.appState, @required this.child});

  static AppState of(BuildContext context) {
    _InheritedStateContainer _inheritedStateContainer = context.inheritFromWidgetOfExactType(_InheritedStateContainer);
    return _inheritedStateContainer.data;
  }

  @override
  _AppStateContainerState createState() => _AppStateContainerState();
}

class _AppStateContainerState extends State<AppStateContainer> {
  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      child: widget.child,
      data: widget.appState,
    );
  }
}
