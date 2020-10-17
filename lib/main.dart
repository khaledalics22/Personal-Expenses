import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/inputs.dart';
import './widgets/transactions_list.dart';
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
  bool _showChart = false;

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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Pesonal Expenses',
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startNewTransaction(context),
        )
      ],
    );
    final txList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionsList(_transactions, _deleteTx),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('show chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            if (!isLandscape)
              Container(
                padding: EdgeInsets.all(5),
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_transactions),
              ),
            if (!isLandscape) txList,
            if (isLandscape)
              _showChart
                  ? Container(
                      padding: EdgeInsets.all(5),
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.5,
                      child: Chart(_transactions),
                    )
                  : txList
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
