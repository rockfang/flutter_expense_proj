import 'dart:math';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  // const TransactionItem(
  //     {Key key, @required this.transaction, @required this.deleteTransaction})
  //     : super(key: key);

const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);


  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _avatorBg;
  List<Color> defautColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    _avatorBg = defautColors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _avatorBg,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(child: Text("￥${widget.transaction.amount}")),
          ),
        ),
        title: Text(widget.transaction.title),
        subtitle: Text(DateFormat.yMd().format(widget.transaction.datetime)),
        trailing: MediaQuery.of(context).size.width > 420
            ? FlatButton.icon(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: const Text('删除'),
                onPressed: () =>
                    widget.deleteTransaction(widget.transaction.id),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                color: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete),
                onPressed: () =>
                    widget.deleteTransaction(widget.transaction.id),
              ),
      ),
    );
    ;
  }
}
