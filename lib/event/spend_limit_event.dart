import 'package:wallet_exe/data/model/SpendLimit.dart';
import 'package:wallet_exe/enums/spend_limit_type.dart';
import 'package:wallet_exe/event/base_event.dart';

class AddSpendLimitEvent extends BaseEvent {
  SpendLimit spendLimit;

  AddSpendLimitEvent(this.spendLimit);
}

class DeleteSpendLimitEvent extends BaseEvent {
  SpendLimit spendLimit;

  DeleteSpendLimitEvent(this.spendLimit);
}

class UpdateSpendLimitEvent extends BaseEvent {
  SpendLimit spendLimit;

  UpdateSpendLimitEvent(this.spendLimit);
}

class GetTotalTransactionBySpendLimitEvent extends BaseEvent {
  SpendLimitType spendLimitType;

  GetTotalTransactionBySpendLimitEvent(this.spendLimitType);
}