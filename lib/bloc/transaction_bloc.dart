import 'dart:async';

import 'package:wallet_exe/bloc/base_bloc.dart';
import 'package:wallet_exe/data/dao/transaction_table.dart';
import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/event/transaction_event.dart';
import 'package:wallet_exe/event/base_event.dart';


class TransactionBloc extends BaseBloc {
  TransactionTable _transactionTable = TransactionTable();

  StreamController<List<Transaction>> _transactionListStreamController = 
    StreamController<List<Transaction>>();

  Stream<List<Transaction>> get transactionListStream => _transactionListStreamController.stream;

  List<Transaction> _transactionListData = List<Transaction>();

  List<Transaction> get transactionListData => _transactionListData;

  initData() async {
    if (_transactionListData.length != 0) return;
    _transactionListData = await _transactionTable.getAll();
    if (_transactionListData == null) return;

    print('transaction bloc init');
    _transactionListStreamController.sink.add(_transactionListData);
  }

  _addTransaction(Transaction transaction) async {
    _transactionTable.insert(transaction);    

    _transactionListData.add(transaction);
    _transactionListStreamController.sink.add(_transactionListData);
  }

  _deleteTransaction(Transaction transaction) async {
    _transactionTable.delete(transaction.id);

    _transactionListData.remove(transaction);
    _transactionListStreamController.sink.add(_transactionListData);
  }

  _updateTransaction(Transaction transaction) async {
    _transactionTable.update(transaction);

    int index =_transactionListData.indexWhere((item) {return item.id == transaction.id;});
    _transactionListData[index] = transaction;
    _transactionListStreamController.sink.add(_transactionListData);
  }

  void dispatchEvent(BaseEvent event) { 
    if (event is AddTransactionEvent) {
      Transaction transaction = Transaction.copyOf(event.transaction);
      _addTransaction(transaction);
    } else if (event is DeleteTransactionEvent) {
      Transaction transaction = Transaction.copyOf(event.transaction);
      _deleteTransaction(transaction);
    } else if (event is UpdateTransactionEvent) {
      Transaction transaction = Transaction.copyOf(event.transaction);
      _updateTransaction(transaction);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}