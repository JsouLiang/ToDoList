import 'package:todo_list/app/data/todo_entry.dart';

class TodoList implements Map<String, TodoEntry> {

  Map<String, TodoEntry> data;

  TodoList([this.data]) {
    if (this.data == null) {
      this.data = Map<String, TodoEntry>();
    }
  }

  @override
  TodoEntry operator [](Object key) {
    return data[key];
  }

  @override
  void operator []=(String key, TodoEntry value) {
    data[key] = value;
  }

  @override
  void addAll(Map<String, TodoEntry> other) {
    data.addAll(other);
  }

  @override
  void addEntries(Iterable<MapEntry<String, TodoEntry>> newEntries) {
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
  Iterable<MapEntry<String, TodoEntry>> get entries => data.entries;

  @override
  void forEach(void Function(String key, TodoEntry value) f) {
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
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(String key, TodoEntry value) f) {
    return data.map(f);
  }

  @override
  TodoEntry putIfAbsent(String key, TodoEntry Function() ifAbsent) {
    return data.putIfAbsent(key, ifAbsent);
  }

  @override
  TodoEntry remove(Object key) {
    return data.remove(key);
  }

  @override
  void removeWhere(bool Function(String key, TodoEntry value) predicate) {
    return data.removeWhere(predicate);
  }

  @override
  TodoEntry update(String key, TodoEntry Function(TodoEntry value) update, {TodoEntry Function() ifAbsent}) {
    return data.update(key, update);
  }

  @override
  void updateAll(TodoEntry Function(String key, TodoEntry value) update) {
    data.updateAll(update);
  }

  @override
  Iterable<TodoEntry> get values => data.values;

}

final TodoList todoList = TodoList();