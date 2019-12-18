class AccountType {
  final int _value;
  final String _name;

  const AccountType._internal(this._value, this._name);

  static const SPENDING = const AccountType._internal(0, 'Tài khoản tiêu dùng');
  static const SAVING = const AccountType._internal(1, 'Tài khoản tiết kiệm');

  int get value => _value;

  String get name => _name;

  static getAllType() {
    return [AccountType.SPENDING, AccountType.SAVING];
  }

  static AccountType valueOf(int value) {
    switch (value) {
      case 0:
        return SPENDING;
      case 1:
        return SAVING;
      default:
        return null;
    }
  }

  static AccountType valueFromName(String name) {
    switch (name) {
      case 'Tài khoản tiêu dùng':
        return SPENDING;
      case 'Tài khoản tiết kiệm':
        return SAVING;
      default:
        return null;
    }
  }
}
