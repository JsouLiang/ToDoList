import 'package:todo_list/app/data/todo_task.dart';

class TodoList implements Map<String, TodoTask> {

  Map<String, TodoTask> data;

  TodoList([this.data]) {
    if (this.data == null) {
      this.data = Map<String, TodoTask>();
    }
  }

  @override
  TodoTask operator [](Object key) {
    return data[key];
  }

  @override
  void operator []=(String key, TodoTask value) {
    data[key] = value;
  }

  @override
  void addAll(Map<String, TodoTask> other) {
    data.addAll(other);
  }

  @override
  void addEntries(Iterable<MapEntry<String, TodoTask>> newEntries) {
    data.addEntries(newEntries);
  }

  @override
  Map<RK, RV> cast<RK, RV>() {
    return data.cast();
  }

  @override
  void clear() {
    data.clear();
  }

  @override
  bool containsKey(Object key) {
    return data.containsKey(key);
  }

  @override
  bool containsValue(Object value) {
    return data.containsValue(value);
  }

  @override
  Iterable<MapEntry<String, TodoTask>> get entries => data.entries;

  @override
  void forEach(void Function(String key, TodoTask value) f) {
    data.forEach(f);
  }

  @override
  bool get isEmpty => data.isEmpty;

  @override
  bool get isNotEmpty => data.isNotEmpty;

  @override
  Iterable<String> get keys => data.keys;

  @override
  int get length => data.length;

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(String key, TodoTask value) f) {
    return data.map(f);
  }

  @override
  TodoTask putIfAbsent(String key, TodoTask Function() ifAbsent) {
    return data.putIfAbsent(key, ifAbsent);
  }

  @override
  TodoTask remove(Object key) {
    return data.remove(key);
  }

  @override
  void removeWhere(bool Function(String key, TodoTask value) predicate) {
    return data.removeWhere(predicate);
  }

  @override
  TodoTask update(String key, TodoTask Function(TodoTask value) update, {TodoTask Function() ifAbsent}) {
    return data.update(key, update);
  }

  @override
  void updateAll(TodoTask Function(String key, TodoTask value) update) {
    data.updateAll(update);
  }

  @override
  Iterable<TodoTask> get values => data.values;

}

final TodoList todoList = TodoList();