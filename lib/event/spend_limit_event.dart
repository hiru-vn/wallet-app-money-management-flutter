import 'package:wallet_exe/data/model/SpendLimit.dart';
import 'package:wallet_exe/event/base_event.dart';

class AddSpendLimitEvent extends BaseEvent {
  SpendLimit spendLimit;

  AddSpendLimitEvent(spendLimit);
}

class DeleteSpendLimitEvent extends BaseEvent {
  SpendLimit spendLimit;

  DeleteSpendLimitEvent(spendLimit);
}

class UpdateSpendLimitEvent extends BaseEvent {
  SpendLimit spendLimit;

  UpdateSpendLimitEvent(spendLimit);
}
