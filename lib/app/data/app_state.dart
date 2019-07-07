import 'package:flutter/widgets.dart';

class AppState {
  bool loading;
  String _email;
  AppState({String email, this.loading = false}) : _email = email;
  factory AppState.loading() => AppState(loading: true);

  set email(value) {
    if (value != _email) {
      _email = value;
      loading = false;
    }
  }

  get email => _email;
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
