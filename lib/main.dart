import 'package:flutter/material.dart';
//import 'package:intl/intl.dart' as intl;
//import 'package:to_do_list/Views/input_view.dart';
import 'package:to_do_list/models/todo_list_manager.dart';
//import 'Views/info_view.dart';
import 'Views/todo_items_list_view.dart';
import 'package:provider/provider.dart';

import 'globals.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dbHelper.init();

  runApp(ChangeNotifierProvider(
      create: (context) {
        var model = TodoListManager();
        model.init();
        return model;
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To Do List',
      home: ToDoItemsView(),
    );
  }
}
