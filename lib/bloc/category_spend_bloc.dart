import 'dart:async';

import 'package:wallet_exe/bloc/base_bloc.dart';
import 'package:wallet_exe/data/remote/category_spend_repository.dart';
import 'package:wallet_exe/enums/transaction_type.dart';
import 'package:wallet_exe/event/base_event.dart';
import 'package:wallet_exe/event/category_spend_event.dart';
import 'package:wallet_exe/widgets/item_spend_chart_circle.dart';

class CategorySpendBloc extends BaseBloc {
  final CategorySpendRepository _categorySpendRepository =
      CategorySpendRepositoryImpl();

  final _categorySpendsStreamController =
      StreamController<List<CategorySpend>>();

  var _categorySpends = <CategorySpend>[];

  Stream<List<CategorySpend>> get categoryStream =>
      _categorySpendsStreamController.stream;

  _getCategorySpendByTransactionType(TransactionType transactionType) async {
    final stateData = await _categorySpendRepository
        .getCategorySpendByTransactionType(transactionType);
    if (stateData.data != null) {
      _categorySpends = stateData.data;
      _categorySpendsStreamController.sink.add(_categorySpends);
    } else {
      errorStreamControler.sink.add(stateData.e);
    }
  }

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is GetCategorySpendByTransactionTypeEvent) {
      _getCategorySpendByTransactionType(event.transactionType);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _categorySpendsStreamController.close();
  }
}
