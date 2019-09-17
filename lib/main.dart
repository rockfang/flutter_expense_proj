import 'package:flutter/material.dart';
import 'package:flutter_expense_proj/transaction.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  List<Transaction> tData = [
    Transaction(title: "早餐", amount: 15, datetime: DateTime.now()),
    Transaction(title: "午餐", amount: 25, datetime: DateTime.now()),
    Transaction(title: "零食", amount: 35, datetime: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("标题"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 100,
              child: Card(
                child: Center(
                  child: Text(
                    "卡片中text文本",
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
                color: Colors.blueAccent,
                elevation: 5,
              ),
            ),
            Card(
              elevation: 4,
              child: Column(
                children: <Widget>[
                  TextField() ,
                  TextField(),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: tData.map((tx) {
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
            )
          ],
        ));
  }
}
