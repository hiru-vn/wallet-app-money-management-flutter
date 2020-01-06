class Language {
  final int _value;
  final String _name;

  const Language._internal(this._value, this._name);

  static const VIETNAM = const Language._internal(0, 'Việt Nam');
  static const English = const Language._internal(1, 'English');

  int get value => _value;

  String get name => _name;

  static getAllType() {
    return [Language.VIETNAM, Language.English];
  }

  static Language valueOf(int value) {
    switch (value) {
      case 0:
        return VIETNAM;
      case 1:
        return English;
      default:
        return null;
    }
  }

  static Language valueFromName(String name) {
    switch (name) {
      case 'Việt Nam':
        return VIETNAM;
      case 'English':
        return English;
      default:
        return null;
    }
  }
}
