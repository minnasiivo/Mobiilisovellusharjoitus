import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import '../models/todo_list_manager.dart';
import 'todo_items_list_view.dart';
import '../models/todo_item.dart';

class InputView extends StatefulWidget {
  final int index;
  const InputView({super.key, this.index = -1});

  @override
  State<InputView> createState() => _InputViewState(index);
}

class _InputViewState extends State<InputView> {
  final _formKey = GlobalKey<FormState>();
  int id = -1;
  String title = "";
  String description = "";
  bool done = false;
  DateTime deadline = DateTime.now();
  int index;
  bool edit = false;

  _InputViewState(this.index) {
    if (index != -1) {
      log("**********muokataan****************");
      edit = true;
    }
  }

  @override
  void initState() {
    super.initState();

    if (edit) {
      TodoItem? item =
          Provider.of<TodoListManager>(context, listen: false).getitem(index);
      if (item != null) {
        setState(() {
          id = item.id;
          title = item.title;
          description = item.description;
          deadline = item.deadline;
          done = item.done;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListManager>(builder: (context, listManager, child) {
      return Scaffold(
          appBar: AppBar(title: const Text('Lisää uusi tehtävä')),
          body: Center(
              child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                initialValue: title,
                autofocus: true,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Tehtävän nimi',
                  labelText: 'Otsikko',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Otsikko vaaditaan';
                  }
                  return null;
                },
                onChanged: (value) {
                  title = value;
                },
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Tehtävän kuvaus',
                  labelText: 'Kuvaus',
                ),
                onChanged: (value) {
                  description = value;
                },
              ),
              _FormDatePicker(
                date: deadline,
                onChanged: (value) {
                  setState(() {
                    deadline = value;
                  });
                },
              ),
              Row(
                children: [
                  Checkbox(
                      value: done,
                      onChanged: (checked) {
                        setState(() {
                          done = checked!;
                        });
                      }),
                  const Text('Valmis'),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    if (edit) {
                      listManager.edit(
                          index,
                          TodoItem(
                              id: id,
                              title: title,
                              description: description,
                              deadline: deadline,
                              done: done));
                    } else {
                      listManager.add(TodoItem(
                          title: title,
                          description: description,
                          deadline: deadline,
                          done: done));
                    }
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Tallennettu'),
                      ));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ToDoItemsView()),
                      );

                      // addNewItem(title, description, deadline, done);
                    }
                  },
                  child: const Text('Tallenna')),
            ]),
          )));
    });
  }
}
/*
addNewItem(title, description, deadline, done) {
  final newTask = TodoItem(
      title: title, description: description, deadline: deadline, done: done);
}
*/

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({
    required this.date,
    required this.onChanged,
  });

  @override
  State<_FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
              width: 10,
            ),
            const Text(
              'Deadline: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              intl.DateFormat('dd.MM.yyyy').format(widget.date),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () async {
                var newDate = await showDatePicker(
                  context: context,
                  initialDate: widget.date,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                // Don't change the date if the date picker returns null.
                if (newDate == null) {
                  return;
                }

                widget.onChanged(newDate);
              },
            )
          ],
        ),
      ],
    );
  }
}
