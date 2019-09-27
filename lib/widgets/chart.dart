import 'package:flutter/material.dart';
import '../widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transaction> _srcTransactionData;
  Chart(this._srcTransactionData);

  List<Map<String, Object>> get _recentTransactionData {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double daySum = 0.0;

      for (int i = 0, length = _srcTransactionData.length; i < length; i++) {
        if (weekDay.year == _srcTransactionData[i].datetime.year &&
            weekDay.month == _srcTransactionData[i].datetime.month &&
            weekDay.day == _srcTransactionData[i].datetime.day) {
          daySum += _srcTransactionData[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': daySum};
    }).reversed.toList();
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
      elevation: 6,
      // child: Text(_recentTransactionData.toString()),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _recentTransactionData.map((t) {
              return Flexible(
                fit: FlexFit.loose,
                child: ChartBar(t['day'], t['amount'],
                    _totalAmount == 0 ? 0 : (t['amount'] as double) / _totalAmount),
              );
            }).toList()),
      ),
    );
  }
}
