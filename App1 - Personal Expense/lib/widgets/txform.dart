import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TxForm extends StatefulWidget {
  final Function addTx;

  TxForm(this.addTx);

  @override
  _TxFormState createState() => _TxFormState();
}

class _TxFormState extends State<TxForm> {
  final _titleControl = TextEditingController();
  final _amountControl = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submit() {
    final title = _titleControl.text;
    final amt = double.parse(_amountControl.text);
    if (title.isEmpty || amt <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(title, amt, _selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((picked) {
      if (picked == null) {
        return;
      }
      _selectedDate = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: (MediaQuery.of(context).viewInsets.bottom + 15)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Title",
            ),
            controller: _titleControl,
            onSubmitted: (_) => _submit(),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Amount",
            ),
            controller: _amountControl,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submit(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(_selectedDate == null
                  ? 'No Date Chosen'
                  : DateFormat.yMMMd().format(_selectedDate)),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(
                  'Choose Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: _datePicker,
              )
            ],
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
            onPressed: _submit,
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
