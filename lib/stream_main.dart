import 'dart:async';

void main() async {
  final Map<int, String> tenMap = {
    0: 'Zero',
    1: 'One',
    2: 'Two',
    3: 'Three',
    4: 'Four',
    5: 'Five',
    6: 'Six',
    7: 'Seven',
    8: 'Eight',
    9: 'Nine',
  };

  Stream<int> intStream = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  Stream<int> newStream;
//  newStream = intStream.where((data) => data % 2 == 1);

//  newStream = intStream.map((data) => data * 10);
//  newStream = intStream.expand((data) => [data, data, data]);
//
//  int result =
//      await intStream.reduce((previous, element) => element + previous);
//  print(result);
//  String joninedValue = await intStream.join("+");
//  print(joninedValue);

//  int foldRes =
//      await intStream.fold(100, (previous, element) => previous + element);
//  print(foldRes);
  newStream = intStream.take(4);

  final transformer = StreamTransformer<int, String>.fromHandlers(
    handleData: (value, sink) {
      sink.add("Transformer: ${value}");
      if (value > 9) {
        sink.addError("Error");
      }
    },
    handleError: (err, stackTrace, sink) {
      print(err);
    },
    handleDone: (sink) {
      print(sink);
    },
  );

  Stream<String> strNewStream = intStream.transform(transformer);

  strNewStream.listen((data) {
    print(data);
  }, onError: (error) => print(error));
//    StreamController.broadcast();
//  StreamController<int> streamController = StreamController<int>();

//  int i = 0;
//  print('End');

//  streamController.stream.map((data) {
//    return data * 10;
//  });
//
//  Stream<int> filterOdd = streamController.stream.where((data) {
//    if (data % 2 == 1) {
//      return true;
//    }
//    return false;
//  });
//  filterOdd.listen((data) {
//    print('listen ${data}');
//  });
//  streamController.stream.listen((data) {
//    print('listen ${data}');
//  });

//  for (int index = 0; index <= 100; index++) {
//    streamController.sink.add(index);
//  }
//
//  /// where 过滤流中一些不想要的数据
//  streamController.stream.where((data) {
//    if (data % 2 == 1) {
//      return true;
//    }
//    return false;
//  });

  /// 设置流中最多能传多少东西
//    streamController.stream.take(4);
//
//    final transformStream =
//        StreamTransformer<int, String>.fromHandlers(handleData: (value, sink) {
//      if (value < 10) {
//        sink.add(tenMap[value]);
//      } else if (value < 100) {
//        sink.add('More');
//      }
//    });
//    streamController.stream.transform(transformStream).listen(
//          (data) => prints(data),
//          onError: (error) => print(error),
//          onDone: () => prints("Finished"),
//        );
}
