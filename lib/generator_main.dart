import 'dart:async';

void main() {
//  print(fib(5));
//  print(printFib());
  Iterable<int> iterable = a();
  Iterator<int> iterator = iterable.iterator;
  while (iterator.moveNext()) {
    print(iterator.current);
  }
//
//  List<int> intList = [];
//  asynchronousNaturalsTo(10)
//      .listen((value) => print('Generator: $value'))
//      .onData((data) => print(data));
//  print(a());
}

Iterable<int> fib(int n) sync* {
  if (n == 1 || n == 0) {
    yield 1;
    return;
  }
  int a = 1;
  int b = 1;
  yield a;
  yield b;
  int i = 3;
  while (i <= n) {
    int c = a + b;
    yield c;
    a = b;
    b = c;
    i++;
  }
}

Iterable<int> printFib() sync* {
  for (int i = 1; i < 5; i++) {
    print('-----');
    yield* fib(i).take(2);
  }
}

Iterable<int> genertoryNaturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}

Iterable<int> ordernaryNaturalsTo(int n) {
  List<int> res = [];
  for (int i = 0; i < n; i++) {
    res.add(i);
  }
  return res;
}

Stream<int> asynchronousNaturalsTo(int n) async* {
  print('Start');
  int k = 0;
  while (k < n) {
//    await Future.delayed(Duration(milliseconds: 20));
    yield k++;
  }
  print('End');
}

//asynchronousNaturalsTo(10).listen((value) => print('Generator: $value'));

Future<Stream<int>> normalAsynchronousNaturalsTo(int n) async {
  StreamController<int> controller = StreamController();

  int k = 0;
  while (k < n) {
    controller.add(k);
    await Future.delayed(Duration(milliseconds: 20));
    k++;
  }
  controller.close();
  return controller.stream;
}

Iterable<int> a() sync* {
  int i = 0;
  while (i < 5) {
    yield i++;
  }
  yield* b(5);
}

Iterable<int> b(int n) sync* {
  int k = 0;
  print('b Begin');
  while (k < n) {
    yield k++;
  }
  print('b end');
}

//await normalAsynchronousNaturalsTo(10)
//..listen((value) => print('Normal: $value'));
