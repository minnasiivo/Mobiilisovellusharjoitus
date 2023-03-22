import 'dart:developer';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/todo_list_manager.dart';

import '../models/todo_item.dart';
import 'info_view.dart';
import 'input_view.dart';

class ToDoItemsView extends StatelessWidget {
  const ToDoItemsView({
    super.key,
  });

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

    List<TodoItem> itemList = [];

    //itemList.add(TodoItem('task 1', 'Do this', DateTime.now(), true));
    //itemList.add(TodoItem('task2', 'Go go go!!!', DateTime.now(), false));

    return Consumer<TodoListManager>(builder: (context, listManager, child) {
      itemList.forEach((item) {
        listManager.add(item);
      });
      return Scaffold(
        appBar: AppBar(
          title: const Text('To Do List'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add_box,
              ),
              tooltip: 'Add new task',
              //label: Text('Add new'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InputView()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InfoView()),
                );
                //do staff
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: listManager.items.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return _buildTaskCard(
              listManager,
              listManager.items[index].done,
              listManager.items[index].title,
              listManager.items[index].description,
              listManager.items[index].deadline,
              context,
              index,
            );
          },
          //titleSection,
          //taskCardSection,
          //  const MyStatelessWidget(),
        ),
      );
    });
  }

  Card _buildTaskCard(
    TodoListManager listManager,
    //Color color,
    bool? taskdone,
    //IconData icon,
    String? label,
    String? content,
    DateTime deadline,
    BuildContext context,
    int index,
  ) {
    label ??= "";
    content ??= "";
    taskdone ??= false;

    String formattedDate = DateFormat('dd.MM.yyyy').format(deadline);
    log("$index**********muokataan****************");
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.check_box,
                color: taskdone ? Colors.pink : Colors.grey),
          ),
          title: Text(label),
          subtitle: Row(children: <Widget>[
            const Text('DL: '),
            Text(formattedDate),
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InputView(
                                index: index,
                              )),
                    );
                  },
                  child: const Text('muokkaa'),
                )),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  listManager.deleteItem(listManager.items[index]);
                },
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
