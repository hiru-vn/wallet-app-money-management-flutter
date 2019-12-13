class SpendLimitType {
  final int _value;
  final String _name;

  const SpendLimitType._internal(this._value, this._name);

  static const WEEKLY = const SpendLimitType._internal(1, 'Weekly');
  static const MONTHLY = const SpendLimitType._internal(2, 'Monthly');
  static const YEARLY = const SpendLimitType._internal(3, 'Yearly');

  int get value => _value;

  String get name => _name;

  static SpendLimitType valueOf(int value) {
    switch (value) {
      case 1:
        return WEEKLY;
      case 2:
        return MONTHLY;
      case 3:
        return YEARLY;
      default:
        return null;
    }
  }
}
