class AccountType {
  final int _value;
  final String _name;

  const AccountType._internal(this._value, this._name);

  static const SPENDING = const AccountType._internal(1, 'Spending');
  static const SAVING = const AccountType._internal(2, 'Saving');

  int get value => _value;

  String get name => _name;

  static AccountType valueOf(int value) {
    switch (value) {
      case 1:
        return SPENDING;
      case 2:
        return SAVING;
      default:
        return null;
    }
  }
}
