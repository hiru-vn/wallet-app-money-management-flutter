class TransactionType {
  final int _value;
  final String _name;

  const TransactionType._internal(this._value, this._name);

  static const INCOME = const TransactionType._internal(0, 'Hạng mục thu');
  static const EXPENSE = const TransactionType._internal(1, 'Hạng mục chi');

  int get value => _value;

  String get name => _name;

  static getAllType() {
    return [TransactionType.INCOME, TransactionType.EXPENSE];
  }

  static TransactionType valueOf(int value) {
    switch (value) {
      case 0:
        return INCOME;
      case 1:
        return EXPENSE;
      default:
        return null;
    }
  }

  static TransactionType valueFromName(String name) {
    switch (name) {
      case 'Hạng mục thu':
        return INCOME;
      case 'Hạng mục chi':
        return EXPENSE;
      default:
        return null;
    }
  }
}
