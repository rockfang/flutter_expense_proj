import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction _transaction;
  final Function _deleteTransaction;

  const TransactionItem(this._transaction, this._deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(child: Text("￥${_transaction.amount}")),
          ),
        ),
        title: Text(_transaction.title),
        subtitle: Text(DateFormat.yMd().format(_transaction.datetime)),
        trailing: MediaQuery.of(context).size.width > 420
            ? FlatButton.icon(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: const Text('删除'),
                onPressed: () => _deleteTransaction(_transaction.id),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                color: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteTransaction(_transaction.id),
              ),
      ),
    );
    ;
  }
}
