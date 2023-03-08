import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class InputView extends StatefulWidget {
  const InputView({super.key});

  @override
  State<InputView> createState() => InputViewState();
}

class InputViewState extends State<InputView> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  String? description;
  bool? done = false;
  DateTime deadline = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Lisää uusi tehtävä')),
        body: Center(
            child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
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
                        done = checked;
                      });
                    }),
                const Text('Valmis'),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Tallennettu'),
                    ));
                  }
                },
                child: const Text('Tallenna')),
          ]),
        )));
  }
}

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