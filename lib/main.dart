import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/inputs.dart';
import 'widgets/transactions_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Theme.of(context).primaryColor,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).primaryColor),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
      title: 'Pesonal Expenses',
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHome> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'new shoes',
        amount: 12345.4,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: 't2',
        title: 'new shirts',
        amount: 13345.4,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: 't3',
        title: 'new pants',
        amount: 143456.45,
        date: DateTime.now().subtract(Duration(days: 3))),
  ];

  void _deleteTx(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _addTransaction({String title, double amount, DateTime date}) {
    setState(() {
      _transactions.add(Transaction(
          amount: amount,
          title: title,
          id: DateTime.now().toString(),
          date: date));
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: InputsWidget(_addTransaction),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesonal Expenses',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Chart(_transactions),
            ),
            TransactionsList(_transactions, _deleteTx),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startNewTransaction(context),
      ),
    );
  }
}
