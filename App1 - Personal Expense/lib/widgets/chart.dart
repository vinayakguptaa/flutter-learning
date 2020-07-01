import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTx;

  Chart(this.recentTx);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double sum = 0.0;
      for (var i = 0; i < recentTx.length; i++) {
        if (recentTx[i].date.day == weekDay.day &&
            recentTx[i].date.month == weekDay.month &&
            recentTx[i].date.year == weekDay.year) {
          sum += recentTx[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': sum,
      };
    }).reversed.toList();
  }

  double get totalSpent {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: groupedTransactions.map((data) {
            return Expanded(
              child: ChartBar(
                label: data['day'],
                spentAmt: data['amount'],
                spentPerc: totalSpent == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpent,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
