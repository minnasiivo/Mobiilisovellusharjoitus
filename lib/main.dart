import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:to_do_list/Views/input_view.dart';

import 'Views/info_view.dart';
import 'Views/todo_items_list_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'List of stuff to be done',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          const Icon(
            Icons.star,
            color: Color.fromARGB(255, 250, 237, 4),
          ),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;
    IconData taskDone = Icons.check_box;
    IconData taskUndone = Icons.check_box_outline_blank_outlined;

    Widget taskCardSection = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCardColumn(color, taskDone, 'task 1', 'Do this', '2023-03-01'),
        _buildCardColumn(color, taskUndone, 'task 2',
            'Tee tämäkin juttu ja heti', '2023-03-8'),
        _buildCardColumn(
            color, taskUndone, 'task 3', 'Give up!!', '2023-03-11'),
      ],
    );

    return MaterialApp(
      title: 'To Do List',
      home: ToDoItemsView(
          titleSection: titleSection, taskCardSection: taskCardSection),
    );
  }
/*
  IconData setIcon(IconData taskIcon) {
    if (taskIcon == Icons.check_box) {
      taskIcon = Icons.check_box_outline_blank_outlined;
    } else
      taskIcon = Icons.check_box;
    return taskIcon;
  }*/

  Card _buildCardColumn(
    Color color,
    IconData icon,
    String label,
    String content,
    String deadline,
  ) {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ListTile(
          //leading: IconButton(icon, color: color),
          leading: IconButton(
            onPressed: () {
              //IconData myIcon = setIcon(icon);
            },
            icon: Icon(icon, color: color),
          ),
          title: Text(label),
          subtitle: Row(children: <Widget>[
            const Text('DL: '),
            Text(deadline),
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {},
                child: const Text('muokkaa'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {},
                child: const Text('poista'),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    ));
  }
}
//class _ToDoItemsView extends State<ToDoItemsView>{}


