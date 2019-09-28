import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _tData;
  final Function _deleteTransaction;
  TransactionList(this._tData, this._deleteTransaction);

  List<Transaction> get _orderedTData {
    _tData.sort((a, b) => a.datetime.compareTo(b.datetime));
    return _tData.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return _orderedTData.length == 0
        ? Column(
            children: <Widget>[
              Text("you have no transaction now ~"),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 300,
                  child: Image.asset(
                    "asssets/images/waiting.png",
                    fit: BoxFit.cover,
                  ))
            ],
          )
        : ListView.builder(
            itemCount: _orderedTData.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                          child: Text("￥${_orderedTData[index].amount}")),
                    ),
                  ),
                  title: Text(_orderedTData[index].title),
                  subtitle: Text(
                      DateFormat.yMd().format(_orderedTData[index].datetime)),
                  trailing: IconButton(
                    color: Theme.of(context).errorColor,
                    icon: Icon(Icons.delete),
                    onPressed: () =>
                        _deleteTransaction(_orderedTData[index].id),
                  ),
                ),
              );
            },
          );
  }
}
