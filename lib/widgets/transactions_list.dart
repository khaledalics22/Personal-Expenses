import 'TransactionsListItem.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTx;
  TransactionsList(this._transactions, this._deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions!!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, idx) {
                return TransactionListItem(
                  _transactions[idx],
                  _deleteTx,
                );
              },
            ),
    );
  }
}
