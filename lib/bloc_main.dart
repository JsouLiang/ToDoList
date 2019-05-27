import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final T bloc;
  final Widget child;

  BlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _BlocProviderState();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.child;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Streams Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<LogicBloc>(
        bloc: LogicBloc(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LogicBloc bloc = BlocProvider.of<LogicBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Stream version of the Counter App')),
      body: Center(
        child: StreamBuilder(
            stream: bloc.outCounter,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text('You hit me: ${snapshot.data} times');
            }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              bloc.incrementCounterSink.add(null);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              bloc.decrementCounterSink.add(null);
            },
            tooltip: 'Increment',
            child: Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}

class LogicBloc implements BlocBase {
  int _counter;

  StreamController<int> _counterController = StreamController<int>();
  Stream<int> get outCounter => _counterController.stream;
  Sink<int> get _counterSink => _counterController.sink;
  StreamController _changeCounterController = StreamController.broadcast();

  StreamController _incrementActionStreamController = StreamController();
  StreamController _decrementActionStreamController = StreamController();
  Sink get incrementCounterSink => _incrementActionStreamController.sink;
  Sink get decrementCounterSink => _decrementActionStreamController.sink;

  LogicBloc() {
    _counter = 0;
    _incrementActionStreamController.stream.listen(_increment);
    _decrementActionStreamController.stream.listen(_decrement);
  }

  void _increment(data) {
    _counter++;
    _counterSink.add(_counter);
  }

  void _decrement(data) {
    _counter--;
    _counterSink.add(_counter);
  }

  @override
  void dispose() {
    _counterController.close();
    _incrementActionStreamController.close();
    _decrementActionStreamController.close();
  }
}

class IncrementBloc implements BlocBase {
  int _counter;

  StreamController<int> _counterController = StreamController<int>();
  Sink<int> get _inAdd => _counterController.sink;
  Stream<int> get outConter => _counterController.stream;

  StreamController _actionController = StreamController();
  Sink get incrementCounter => _actionController.sink;

  IncrementBloc() {
    _counter = 0;
    _actionController.stream.listen(_handleLogic);
  }

  void _handleLogic(data) {
    _counter = _counter + 1;
    _inAdd.add(_counter);
  }

  @override
  void dispose() {
    _actionController.close();
    _counterController.close();
  }
}
