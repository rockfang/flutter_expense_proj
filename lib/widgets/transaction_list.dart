import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> _tData;
  TransactionList(this._tData);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: _tData.length == 0
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
              itemCount: _tData.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 2),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '￥ ${_tData[index].amount.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _tData[index].title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          // DateFormat('yyyy/MMdd HH:ss').format(tx.datetime),
                          DateFormat.yMMMd().format(_tData[index].datetime),
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
    );
  }
}
