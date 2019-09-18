import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  Function _addHandler;
  NewTransaction(this._addHandler);
  final TextEditingController titleInputController = TextEditingController();
  final TextEditingController accountInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: '请输入消费项名称'),
            controller: titleInputController,
          ),
          TextField(
            decoration: InputDecoration(labelText: '请输入消费金额'),
            controller: accountInputController,
          ),
          FlatButton(
            child: Text(
              "提交",
              style: TextStyle(color: Colors.purple),
            ),
            onPressed: () {
              _addHandler(titleInputController.text,double.parse(accountInputController.text));
              print(titleInputController.text);
              print(accountInputController.text);
            },
          )
        ],
      ),
    );
  }
}
