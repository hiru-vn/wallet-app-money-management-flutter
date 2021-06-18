import 'dart:async';

import 'package:wallet_exe/bloc/base_bloc.dart';
import 'package:wallet_exe/data/dao/transaction_table.dart';
import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/data/repository/transaction_repository.dart';
import 'package:wallet_exe/enums/transaction_type.dart';
import 'package:wallet_exe/event/transaction_event.dart';
import 'package:wallet_exe/event/base_event.dart';

class TransactionBloc extends BaseBloc {
  TransactionTable _transactionTable = TransactionTable();
  TransactionRepository _transactionRepository = TransactionRepositoryIml();

  StreamController<List<Transaction>> _transactionListStreamController =
      StreamController<List<Transaction>>();

  Stream<List<Transaction>> get transactionListStream =>
      _transactionListStreamController.stream;

  List<Transaction> _transactionListData = List<Transaction>();

  List<Transaction> get transactionListData => _transactionListData;

  initData() async {
    if (_transactionListData.length != 0) return;
    final stateData = await _transactionRepository.getAllTransaction();
    if (stateData.data != null) {
      _transactionListData = stateData.data;
      _transactionListStreamController.sink.add(_transactionListData);
    } else {
      errorStreamControler.sink.add(stateData.e);
    }
    print('transaction bloc init');
  }

  _addTransaction(Transaction transaction) async {
    final stateData = await _transactionRepository.addTransaction(transaction);
    if (stateData.data != null) {
      _transactionListData.add(stateData.data);
      _transactionListStreamController.sink.add(_transactionListData);
    } else {
      errorStreamControler.sink.add(stateData.e);
    }
  }

  _deleteTransaction(Transaction transaction) async {
    final stateData =
        await _transactionRepository.deleteTransaction(transaction.id);
    if (stateData.data ?? false) {
      _transactionListData.remove(transaction);
      _transactionListStreamController.sink.add(_transactionListData);
    } else {
      errorStreamControler.sink.add(stateData.e);
    }
  }

  _updateTransaction(Transaction transaction) async {
    int index = _transactionListData.indexWhere((item) {
      return item.id == transaction.id;
    });
    final statData =
        await _transactionRepository.updateTransaction(transaction);
    if (statData.data ?? false) {
      _transactionListData[index] = transaction;
      _transactionListStreamController.sink.add(_transactionListData);
    } else {
      errorStreamControler.sink.add(statData.e);
    }
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
    _transactionListStreamController.close();
    super.dispose();
  }
}
