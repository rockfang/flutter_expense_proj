import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _tData;
  final Function _deleteTransaction;
  const TransactionList(this._tData, this._deleteTransaction);

  List<Transaction> get _orderedTData {
    _tData.sort((a, b) => a.datetime.compareTo(b.datetime));
    return _tData.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return _tData.length == 0
        ? LayoutBuilder(
            builder: (ctx, contraints) {
              return Column(
                children: <Widget>[
                  Text("you have no transaction now ~"),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: contraints.maxHeight * 0.7,
                    child: Image.asset(
                      "asssets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView(
            children: _tData.map((t) => 
              TransactionItem(
                  key: ValueKey(t.id),
                  transaction: t,
                  deleteTransaction: _deleteTransaction)
            ).toList(),
          );
    // : ListView.builder(
    //     itemCount: _orderedTData.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return TransactionItem(
    //           key: UniqueKey(),
    //           transaction: _orderedTData[index],
    //           deleteTransaction: _deleteTransaction);
    //     },
    //   );
  }
}
