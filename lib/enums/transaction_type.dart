class TransactionType {
  final int _value;
  final String _name;

  const TransactionType._internal(this._value, this._name);

  static const INCOME = const TransactionType._internal(1, 'Income');
  static const EXPENSE = const TransactionType._internal(2, 'Expense');

  int get value => _value;

  String get name => _name;

  static TransactionType valueOf(int value) {
    switch (value) {
      case 1:
        return INCOME;
      case 2:
        return EXPENSE;
      default:
        return null;
    }
  }
}
