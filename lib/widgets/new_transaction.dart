import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function _addHandler;
  NewTransaction(this._addHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleInputController = TextEditingController();
  final TextEditingController _accountInputController = TextEditingController();
  DateTime _pickedDate;
  void _showDatePicker() {
    showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      locale: Locale('en'),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _pickedDate = date;
      });
    });
  }

  void submitData() {
    String _title = _titleInputController.text;
    double _amount = double.parse(_accountInputController.text);
    if (_titleInputController.text.isEmpty ||
        _amount <= 0 ||
        _pickedDate == null) {
      return;
    }
    widget._addHandler(_title, _amount, _pickedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: '请输入消费项名称'),
                controller: _titleInputController,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: '请输入消费金额'),
                controller: _accountInputController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_pickedDate == null
                          ? "还没有选择日期哦"
                          : "消费日期:${DateFormat.yMd().format(_pickedDate)}"),
                    ),
                    FlatButton(
                      child: Text(
                        "选择日期",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      onPressed: _showDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).appBarTheme.textTheme.button.color,
                child: Text(
                  "提交",
                ),
                onPressed: submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
