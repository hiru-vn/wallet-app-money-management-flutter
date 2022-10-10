import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/event/base_event.dart';

class AddTransactionEvent extends BaseEvent {
  Transaction transaction;

  AddTransactionEvent(this.transaction);
}

class DeleteTransactionEvent extends BaseEvent {
  Transaction transaction;

  DeleteTransactionEvent(this.transaction);
}

class UpdateTransactionEvent extends BaseEvent {
  Transaction transaction;

  UpdateTransactionEvent(this.transaction);
}