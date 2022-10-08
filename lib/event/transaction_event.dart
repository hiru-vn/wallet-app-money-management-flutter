import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/event/base_event.dart';

class AddTransactionEvent extends BaseEvent {
  Transaction transaction;

  AddTransactionEvent(transaction);
}

class DeleteTransactionEvent extends BaseEvent {
  Transaction transaction;

  DeleteTransactionEvent(transaction);
}

class UpdateTransactionEvent extends BaseEvent {
  Transaction transaction;

  UpdateTransactionEvent(transaction);
}
