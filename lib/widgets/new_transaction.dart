import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  Function _addHandler;
  NewTransaction(this._addHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleInputController = TextEditingController();

  final TextEditingController accountInputController = TextEditingController();

  void submitData() {
    String title = titleInputController.text;
    double amount = double.parse(accountInputController.text);
    if (titleInputController.text.isEmpty || amount <= 0) {
      return;
    }
    widget._addHandler(title, amount);
    Navigator.of(context).pop();
  }

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
            keyboardType: TextInputType.text,
            onSubmitted: (_) => submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: '请输入消费金额'),
            controller: accountInputController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitData(),
          ),
          FlatButton(
            child: Text(
              "提交",
              style: TextStyle(color: Colors.purple),
            ),
            onPressed: submitData,
          )
        ],
      ),
    );
  }
}
