import 'package:wallet_exe/data/model/UserAccount.dart';
import 'package:wallet_exe/event/base_event.dart';

class LoginEvent extends BaseEvent {
  String email;
  String password;

  LoginEvent(this.email, this.password);
}

class AddUserEvent extends BaseEvent {
  UserAccount userAccount;

  AddUserEvent(this.userAccount);
}

class UpdateUserEvent extends BaseEvent {
  UserAccount userAccount;

  UpdateUserEvent(this.userAccount);
}

class GetUserEvent extends BaseEvent {
  UserAccount userAccount;

  GetUserEvent(this.userAccount);
}

class GetCurrentUserEvent extends BaseEvent {
  GetCurrentUserEvent();
}

class DeleteCurrentUserEvent extends BaseEvent {
  DeleteCurrentUserEvent();
}
