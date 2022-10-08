import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/event/base_event.dart';

class AddAccountEvent extends BaseEvent {
  Account account;

  AddAccountEvent(account);
}

class DeleteAccountEvent extends BaseEvent {
  Account account;

  DeleteAccountEvent(account);
}

class UpdateAccountEvent extends BaseEvent {
  Account account;

  UpdateAccountEvent(account);
}
