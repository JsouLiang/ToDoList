import 'package:flutter/material.dart';

void main() => runApp(StatefulContainer());

class InheritedTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: InheritedContainerWidget(
          data: "InheritedContainer Data",
          child: ContentWidget(),
        ),
      ),
    );
  }
}

class InheritedContainerWidget extends InheritedWidget {
  InheritedContainerWidget({Key key, this.data, Widget child})
      : super(key: key, child: child);

  final String data;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return data != (oldWidget as InheritedContainerWidget).data;
  }
}

class ContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InheritedContainerWidget inheritedWidget =
        context.inheritFromWidgetOfExactType(InheritedContainerWidget);
    return Text(inheritedWidget.data);
  }
}

class StatefulContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StatefulContainerState();
  }
}

class StatefulContainerState extends State<StatefulContainer> {
  String _data = "Initial String";
  static int pressedCount = 0;
  void pressedAct() {
    setState(() {
      _data = "Pressed count: ${++pressedCount}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InheritedContainerWidget(
        data: _data,
        child: RaisedButton(
          onPressed: () => this.pressedAct(),
          child: ContentWidget(),
        ),
      ),
    );
  }
}
