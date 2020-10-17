import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../widgets/chart_element.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _transactions;
  Chart(this._transactions);
  List<Map<String, Object>> get getGroupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < _transactions.length; i++) {
        if (_transactions[i].date.day == weekDay.day &&
            _transactions[i].date.month == weekDay.month &&
            _transactions[i].date.year == weekDay.year) {
          totalSum += _transactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'tx': totalSum,
        'fraction': _totalTxAmount > 0.0 ? totalSum / _totalTxAmount : 0.0
      };
    });
  }

  double get _totalTxAmount {
    var sum = 0.0;
    for (var i = 0; i < _transactions.length; i++) {
      sum += _transactions[i].amount;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: getGroupedTransactions.map((tx) {
          return Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: ChartElement(tx['day'], tx['tx'], tx['fraction']),
            ),
          );
        }).toList(),
      ),
    );
  }
}
