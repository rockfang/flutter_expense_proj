import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expense',
      //国际化
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],///
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple, //这个是设置通用主题,默认的颜色都会走通用主题。
          accentColor: Colors.amber, // 强调色。默认FloatingActionButton就会读取这个颜色
          fontFamily: "OpenSans", //指定yaml配置的fontfamily
          errorColor: Colors.lightBlue, //指定errorColor的颜色，在表达error的地方可以全局的它
          //单独指定appbar的主题
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: "Quicksand",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  button: TextStyle(color: Colors.white),
                ),
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 16,
                  fontWeight: FontWeight.bold))),
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
        id: "1",
        title: "breakfirst",
        amount: 15,
        datetime: DateTime.now().subtract(Duration(days: 7))),
    // Transaction(
    //     id: "2",
    //     title: "lunch",
    //     amount: 25,
    //     datetime: DateTime.now().subtract(Duration(days: 6))),
    // Transaction(
    //     id: "3",
    //     title: "dinner",
    //     amount: 35,
    //     datetime: DateTime.now().subtract(Duration(days: 5))),
    // Transaction(
    //     id: "4",
    //     title: "dinner",
    //     amount: 35,
    //     datetime: DateTime.now().subtract(Duration(days: 4))),
    // Transaction(
    //     id: "5",
    //     title: "dinner",
    //     amount: 35,
    //     datetime: DateTime.now().subtract(Duration(days: 2))),
    // Transaction(
    //     id: "6",
    //     title: "dinner",
    //     amount: 35,
    //     datetime: DateTime.now().subtract(Duration(days: 3))),
  ];
  void _addTransaction(String title, double amount, DateTime datetime) {
    Transaction _newOne = Transaction(
        amount: amount,
        title: title,
        id: DateTime.now().toString(),
        datetime: datetime);
setState(() {
  _tData.add(_newOne);
});
  }

  void _deleteTransaction(String id) {
    setState(() {
      _tData.removeWhere((t) => t.id == id);
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

  List<Transaction> get _recentTransactions {
    return _tData.where((t) {
      return t.datetime.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool _landShowCharts = false;
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _isLandscape = _mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("My Expense"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _showAddTransaction(context),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () => _showAddTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
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
          );

    final _pageBody = SafeArea(///SafeArea包裹，处理iOS中的遮挡问题
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text('展示表格',style: Theme.of(context).textTheme.title,),
                Switch.adaptive(
                activeColor: Theme.of(context).accentColor,
                value: _landShowCharts,
                onChanged: (value) {
                  setState(() {
                    _landShowCharts = value;
                  });
                },
              ),
            ],),
              
            if (_isLandscape)
              _landShowCharts
                  ? Container(
                      height: (_mediaQuery.size.height -
                              appBar.preferredSize.height -
                              _mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions))
                  : Container(
                      height: (_mediaQuery.size.height -
                              appBar.preferredSize.height -
                              _mediaQuery.padding.top) *
                          0.7,
                      width: double.infinity,
                      child: TransactionList(_tData, _deleteTransaction)),
            if (!_isLandscape)
              Container(
                  height: (_mediaQuery.size.height -
                          appBar.preferredSize.height -
                          _mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransactions)),
            if (!_isLandscape)
              Container(
                  height: (_mediaQuery.size.height -
                          appBar.preferredSize.height -
                          _mediaQuery.padding.top) *
                      0.7,
                  width: double.infinity,
                  child: TransactionList(_tData, _deleteTransaction)),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: _pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _showAddTransaction(context),
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
  }
}
