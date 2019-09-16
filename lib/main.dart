import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

/**
 * 1.Column的高度是默认是double.infinity 即尽可能占满屏幕的 （通过MainAxisAlignment就能看出来）
 * 2.Card本身的宽高由其child的宽高决定,默认包裹child的宽高。
 * 3.Text的宽高，默认是包裹文本 textAlign设置text在其父布局水平方向的排版
 * 4.设置Text间隔样式： 给Text增加一层container包裹后设置container样式达到效果
 * 5.
 */
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("标题"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Container(
                width: 400,
                height: 400,
                child: Text(
                  "卡片中text文本",
                  style: TextStyle(backgroundColor: Colors.green),
                  textAlign: TextAlign.center,
                ),
                color: Colors.orange,
              ),
            ),
            Card(
              child: Text("用于写事务列表"),
            )
          ],
        ));
  }
}
