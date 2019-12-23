class SpendLimitType {
  final int _value;
  final String _name;

  const SpendLimitType._internal(this._value, this._name);

  static const WEEKLY = const SpendLimitType._internal(0, 'Hàng tuần');
  static const MONTHLY = const SpendLimitType._internal(1, 'Hàng tháng');
  static const YEARLY = const SpendLimitType._internal(2, 'Hàng năm');

  int get value => _value;

  String get name => _name;

  static SpendLimitType valueOf(int value) {
    switch (value) {
      case 0:
        return WEEKLY;
      case 1:
        return MONTHLY;
      case 2:
        return YEARLY;
      default:
        return null;
    }
  }
}
