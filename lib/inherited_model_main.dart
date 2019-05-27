import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inherited Model Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  int prop1 = 0;
  int prop2 = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: InheritedModelContainer(
        prop1: prop1,
        prop2: prop2,
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => this.setState(() {
                    ++this.prop1;
                  }),
              child: AsInheritedWidgetProp1(),
            ),
            RaisedButton(
              onPressed: () => this.setState(() {
                    ++this.prop2;
                  }),
              child: AsInheritedWidgetProp2(),
            )
          ],
        ),
      ),
    );
  }
}

enum DependenciesType { Prop1, Prop2 }

class InheritedModelContainer extends InheritedModel<DependenciesType> {
  final int prop1;
  final int prop2;

  InheritedModelContainer({
    Key key,
    @required Widget child,
    this.prop1,
    this.prop2,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    InheritedModelContainer container = oldWidget as InheritedModelContainer;
    return container.prop1 != prop1 || container.prop2 != prop2;
  }

  @override
  bool updateShouldNotifyDependent(InheritedModel<DependenciesType> oldWidget,
      Set<DependenciesType> dependencies) {
    InheritedModelContainer oldContainer = oldWidget as InheritedModelContainer;
    return (dependencies.contains(DependenciesType.Prop1) &&
            oldContainer.prop1 != prop1) ||
        (dependencies.contains(DependenciesType.Prop2) &&
            oldContainer.prop2 != prop2);
  }

  static InheritedModelContainer of(BuildContext context,
      {DependenciesType aspect}) {
    return InheritedModel.inheritFrom<InheritedModelContainer>(context,
        aspect: aspect);
  }
}

class AsInheritedWidgetProp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InheritedModelContainer model =
        InheritedModelContainer.of(context, aspect: DependenciesType.Prop1);
    return Text("Values: ${model.prop1}");
  }
}

class AsInheritedWidgetProp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InheritedModelContainer model =
        InheritedModelContainer.of(context, aspect: DependenciesType.Prop2);
    return Text("Values: ${model.prop2}");
  }
}
