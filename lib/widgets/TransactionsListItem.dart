import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction _transaction;
  final Function _deleteTx;
  TransactionListItem(this._transaction, this._deleteTx);
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  '\$${_transaction.amount}',
                ),
              ),
            ),
          ),
          title: Text(
            _transaction.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(DateFormat.yMMMd().format(_transaction.date)),
          trailing: IconButton(
              color: Theme.of(context).errorColor,
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteTx(_transaction.id);
              }),
        ));
  }
}
