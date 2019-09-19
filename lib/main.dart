import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expense',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple, //这个是设置通用主题,默认的颜色都会走通用主题。
        accentColor: Colors.amber, // 强调色。默认FloatingActionButton就会读取这个颜色
        fontFamily: "OpenSans", //指定yaml配置的fontfamily
        //单独指定appbar的主题
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: "Quicksand",
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 16,
            fontWeight: FontWeight.bold
          )
        )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _tData = [
    Transaction(
        id: "1", title: "breakfirst", amount: 15, datetime: DateTime.now()),
    Transaction(id: "2", title: "lunch", amount: 25, datetime: DateTime.now()),
    Transaction(id: "3", title: "dinner", amount: 35, datetime: DateTime.now()),
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

  void _showAddTransaction(BuildContext bct) {
    showModalBottomSheet(
        context: bct,
        builder: (_) {
          ///添加手势处理弹框空白点击也返回，以及组织点击事件传递到弹框后面的组件
          return GestureDetector(
            child: NewTransaction(_addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Expense"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => _showAddTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                color: Theme.of(context).primaryColor,
                elevation: 5,
              ),
            ),
            TransactionList(_tData),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
