import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class InputsWidget extends StatefulWidget {
  final Function addTransaction;

  InputsWidget(this.addTransaction);

  @override
  _InputsWidgetState createState() => _InputsWidgetState();
}

class _InputsWidgetState extends State<InputsWidget> {
  final titleCtr = TextEditingController();

  final amountCtr = TextEditingController();
  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleCtr,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: amountCtr,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(_selectedDate == null
                            ? 'No Date Chosen!'
                            : 'picked date: ${DateFormat.yMd().format(_selectedDate)}'),
                      ),
                      FlatButton(
                        child: Text(
                          'choose date',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        onPressed: _presentDatePicker,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                  child: FlatButton(
                    textColor: Theme.of(context).textTheme.button.color,
                    color: Theme.of(context).primaryColor,
                    child: Text('ADD'),
                    onPressed: () {
                      final amount = double.parse(
                          amountCtr.text.isEmpty ? '0.0' : amountCtr.text);
                      if (titleCtr.text.isEmpty ||
                          amountCtr.text.isEmpty ||
                          _selectedDate == null ||
                          amount < 0) {
                        Toast.show(
                          'Invalid Inputs',
                          context,
                          duration: Toast.LENGTH_SHORT,
                        );
                      } else {
                        widget.addTransaction(
                            title: titleCtr.text,
                            amount: amount,
                            date: _selectedDate);
                        Toast.show(
                          'transaction added ؛/',
                          context,
                          duration: Toast.LENGTH_SHORT,
                        );
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
