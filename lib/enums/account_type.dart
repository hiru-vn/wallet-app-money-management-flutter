class AccountType {
  final int _value;
  final String _name;

  const AccountType._internal(this._value, this._name);

  static const SPENDING = const AccountType._internal(0, 'Spending');
  static const SAVING = const AccountType._internal(1, 'Saving');

  int get value => _value;

  String get name => _name;

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
}
