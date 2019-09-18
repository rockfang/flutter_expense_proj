import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  List<Transaction> _tData = [
    Transaction(id:"1",title: "早餐", amount: 15, datetime: DateTime.now()),
    Transaction(id:"2",title: "午餐", amount: 25, datetime: DateTime.now()),
    Transaction(id:"3",title: "零食", amount: 35, datetime: DateTime.now()),
  ];

  void _addTransaction(String title, double amount) {
    Transaction _newOne = Transaction(
        amount: amount,
        title: title,
        id: DateTime.now().toString(),
        datetime: DateTime.now());
    setState(() {
      _tData.add(_newOne);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addTransaction),
        TransactionList(_tData),
      ],
    );
  }
}
