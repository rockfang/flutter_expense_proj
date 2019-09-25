import 'package:flutter/material.dart';
import '../widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transaction> _srcTransactionData;
  Chart(this._srcTransactionData);

  List<Map<String, Object>> get _recentTransactionData {
    return List.generate(7, (index) {
      print('---index:$index');
      final weekDay = DateTime.now().subtract(Duration(days: index));
      print('---weekDay:$weekDay');

      double daySum = 0;
      if (index < _srcTransactionData.length) {
        if (weekDay.year == _srcTransactionData[index].datetime.year &&
            weekDay.month == _srcTransactionData[index].datetime.month &&
            weekDay.day == _srcTransactionData[index].datetime.day) {
          daySum += _srcTransactionData[index].amount;
        }
      }

      print('---weekDay:$weekDay');
      print(DateFormat.E().format(weekDay));
      print(daySum);
      return {'day': DateFormat.E().format(weekDay), 'amount': daySum};
    });
  }

  ///求和的另一种写法
  double get _totalAmount {
    return _recentTransactionData.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 5,
      // child: Text(_recentTransactionData.toString()),
      child: Row(
          children: _recentTransactionData.map((t) {
        return ChartBar(
            t['day'], t['amount'], (t['amount'] as double) / _totalAmount);
      }).toList()),
    );
  }
}
