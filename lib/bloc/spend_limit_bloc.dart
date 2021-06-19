import 'dart:async';

import 'package:wallet_exe/bloc/base_bloc.dart';
import 'package:wallet_exe/data/dao/spend_limit_table.dart';
import 'package:wallet_exe/data/model/SpendLimit.dart';
import 'package:wallet_exe/data/repository/transaction_repository.dart';
import 'package:wallet_exe/enums/spend_limit_type.dart';
import 'package:wallet_exe/event/spend_limit_event.dart';
import 'package:wallet_exe/event/base_event.dart';

class SpendLimitBloc extends BaseBloc {
  SpendLimitTable _spendLimitTable = SpendLimitTable();
  final TransactionRepository _transactionRepository =
      TransactionRepositoryIml();

  StreamController<int> _spendTotalTransactionController =
      StreamController<int>();

  Stream<int> get total => _spendTotalTransactionController.stream;

  StreamController<List<SpendLimit>> _spendLimitListStreamController =
      StreamController<List<SpendLimit>>();

  Stream<List<SpendLimit>> get spendLimitListStream =>
      _spendLimitListStreamController.stream;

  List<SpendLimit> _spendLimitListData = List<SpendLimit>();

  List<SpendLimit> get spendLimitListData => _spendLimitListData;

  initData() async {
    if (_spendLimitListData.length != 0) return;
    _spendLimitListData = await _spendLimitTable.getAll();
    if (_spendLimitListData == null) return;

    _spendLimitListStreamController.sink.add(_spendLimitListData);
  }

  _addSpendLimit(SpendLimit spendLimit) async {
    _spendLimitTable.insert(spendLimit);

    _spendLimitListData.add(spendLimit);
    _spendLimitListStreamController.sink.add(_spendLimitListData);
  }

  _deleteSpendLimit(SpendLimit spendLimit) async {
    final index = _spendLimitListData.indexWhere((item) {
      return item.type.name == spendLimit.type.name;
    });
    _spendLimitTable.delete(_spendLimitListData[index].id);
    _spendLimitListData.removeAt(index);
    _spendLimitListStreamController.sink.add(_spendLimitListData);
  }

  _updateSpendLimit(SpendLimit spendLimit) async {
    int index = _spendLimitListData.indexWhere((item) {
      return item.type.name == spendLimit.type.name;
    });
    spendLimit.id = _spendLimitListData[index].id;
    _spendLimitTable.update(spendLimit);
    _spendLimitListData[index] = spendLimit;
    _spendLimitListStreamController.sink.add(_spendLimitListData);
  }

  _getTotalTransactionBySpendLimit(SpendLimitType spendLimitType) async {
    final stateData =
        await _transactionRepository.getTransactionBySpendLimit(spendLimitType);
    stateData.data != null
        ? _spendTotalTransactionController.sink.add(stateData.data)
        : errorStreamControler.sink.add(stateData.e);
  }

  void dispatchEvent(BaseEvent event) {
    if (event is AddSpendLimitEvent) {
      SpendLimit spendLimit = SpendLimit.copyOf(event.spendLimit);
      _addSpendLimit(spendLimit);
    } else if (event is DeleteSpendLimitEvent) {
      SpendLimit spendLimit = SpendLimit.copyOf(event.spendLimit);
      _deleteSpendLimit(spendLimit);
    } else if (event is UpdateSpendLimitEvent) {
      SpendLimit spendLimit = SpendLimit.copyOf(event.spendLimit);
      _updateSpendLimit(spendLimit);
    } else if (event is GetTotalTransactionBySpendLimitEvent) {
      _getTotalTransactionBySpendLimit(event.spendLimitType);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _spendLimitListStreamController.close();
    _spendTotalTransactionController.close();
    super.dispose();
  }
}
