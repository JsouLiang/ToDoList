import 'package:flutter/material.dart';

void main() => runApp(StatelessRoot());

class StatefulRoot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StatefulRootState();
  }
}

class StatefulRootState extends State<StatefulRoot> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              StatelessComponent("1"),
              StatelessComponent("2"),
              GestureDetector(
                child: StatelessComponent("${_count}"),
                onTap: () {
                  setState(() {
                    ++_count;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatelessRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              StatelessComponent("1"),
              StatelessComponent("2"),
              StatefulComponent(0)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "Add",
          onPressed: () {},
        ),
      ),
    );
  }
}

class StatefulComponent extends StatefulWidget {
  int _count;
  StatefulComponent(this._count);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StatefulComponentState();
  }
}

class StatefulComponentState extends State<StatefulComponent> {
  @override
  Widget build(BuildContext context) {
    print("create statefule widget");
    return GestureDetector(
      child: Text("Statefule Component ${widget._count}"),
      onTap: () {
        setState(() {
          ++widget._count;
        });
      },
    );
  }
}

class StatelessComponent extends StatelessWidget {
  final String title;
  StatelessComponent(this.title);

  @override
  Widget build(BuildContext context) {
    print("Create Stateless Component cost 2ms");
    return Text("StatelessComonent: ${title}");
  }
}
