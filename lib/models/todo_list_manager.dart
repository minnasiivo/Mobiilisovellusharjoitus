import 'dart:collection';
import 'dart:developer';
//import 'dart:developer';
//import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:to_do_list/globals.dart';
import 'package:to_do_list/models/todo_item.dart';

class TodoListManager extends ChangeNotifier {
  /// Internal, private state of the itemlist
  final List<TodoItem> _items = [];

  TodoListManager() {}

  Future<void> init() async {
    loadFromDb();
  }

  /// An unmodifiable view of the items in the todoitems -list.
  UnmodifiableListView<TodoItem> get items => UnmodifiableListView(_items);

  /// Adds [item] to todolist. This and [removeAll] are the only ways to modify the
  /// todoitems list from the outside.
  void add(TodoItem item) {
    _items.add(item);
    dbHelper.insert(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

//Removes one item from db
  void deleteItem(TodoItem item) {
    {
      dbHelper.delete(item.id);
      _items.remove(item);
      notifyListeners();
    }
  }

  /// Removes all items from the list.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  TodoItem? getitem(int index) {
    if (_items.length > index && index >= 0) {
      return _items[index];
    }
    return null;
  }

  void edit(int index, TodoItem item) {
    if (_items.length > index && index >= 0) {
      _items[index] = item;
      log("*!*!*!*!*!!**!!*!*!TESTATAAAAAAAN");
      dbHelper.update(item);
      notifyListeners();
    }
  }

  void loadFromDb() async {
    final list = await dbHelper.queryAllRows();
    for (TodoItem item in list) {
      _items.add(item);
    }
    notifyListeners();
  }
}
