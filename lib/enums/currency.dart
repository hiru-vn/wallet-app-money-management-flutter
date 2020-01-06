class Currency {
  final int _value;
  final String _name;

  const Currency._internal(this._value, this._name);

  static const VIETNAM = const Currency._internal(0, 'Vietnam dong');
  static const USA = const Currency._internal(1, 'US dollar');

  int get value => _value;

  String get name => _name;

  static getAllType() {
    return [Currency.VIETNAM, Currency.USA];
  }

  static Currency valueOf(int value) {
    switch (value) {
      case 0:
        return VIETNAM;
      case 1:
        return USA;
      default:
        return null;
    }
  }

  static Currency valueFromName(String name) {
    switch (name) {
      case 'Vietnam dong':
        return VIETNAM;
      case 'US dollar':
        return USA;
      default:
        return null;
    }
  }
}
