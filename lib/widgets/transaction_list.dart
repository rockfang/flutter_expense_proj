import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> _tData;
  TransactionList(this._tData);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _tData.map((tx) {
        return Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 2),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: EdgeInsets.all(5),
              child: Text(
                '￥ ${tx.amount}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tx.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  // DateFormat('yyyy/MMdd HH:ss').format(tx.datetime),
                  DateFormat.yMMMd().format(tx.datetime),
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            )
          ],
        );
      }).toList(),
    );
  }
}
