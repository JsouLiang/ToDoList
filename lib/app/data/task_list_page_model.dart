import 'package:flutter/material.dart';

class TaskListPageModel<E> {
  final GlobalKey<AnimatedListState> listKey;
  final List<E> _items;
  Iterable<E> initialItems;
  final dynamic removedItemBuilder;

  int get length => _items.length;
  E operator [](int index) => _items[index];
  int indexOf(E item) => _items.indexOf(item);

  TaskListPageModel({
    this.listKey,
    this.removedItemBuilder,
    Iterable<E> initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  AnimatedListState get _animatedList => listKey.currentState;
  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  void remove(E item) {
    final int index = _items.indexOf(item);
    _items.remove(item);
    _animatedList.removeItem(index, (context, animation) {
      return removedItemBuilder(item, context, animation);
    });
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index,
          (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }
}
