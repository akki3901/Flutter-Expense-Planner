import 'dart:math';
import 'package:expense_planner/model/transaction.dart';
import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem(
      {Key key, @required this.transaction, @required this.deleteTx})
      : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availabeColors = [Colors.red, Colors.blue, Colors.amber, Colors.purple];
    _bgColor = availabeColors[Random().nextInt(4)];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    void _dismissDialog() {
      Navigator.pop(context);
    }

    void _showAlertDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Delete Item'),
              content: Text('Are you sure to delete the item?'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () {
                    _dismissDialog();
                    widget.deleteTx(widget.transaction.id);
                  },
                  child: Text('Yes'),
                )
              ],
            );
          });
    }

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${widget.transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
                icon: Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                onPressed: () => _showAlertDialog(),
                label: Text('Delete'))
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => _showAlertDialog()),
      ),
    );
  }
}
