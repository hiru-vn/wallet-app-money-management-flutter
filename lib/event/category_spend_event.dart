import 'package:wallet_exe/enums/transaction_type.dart';

import 'base_event.dart';

class GetCategorySpendByTransactionTypeEvent extends BaseEvent {
  TransactionType transactionType;

  GetCategorySpendByTransactionTypeEvent(this.transactionType);
}
