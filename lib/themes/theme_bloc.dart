import 'package:wallet_exe/themes/theme.dart';
import 'package:rxdart/rxdart.dart';

class ThemeBloc {
  final _theme = BehaviorSubject<AppTheme>();
  Function(AppTheme) get inTheme => _theme.sink.add;
  Stream<AppTheme> get outTheme => _theme.stream;
  ThemeBloc() {
    print(' — — — -APP BLOC INIT — — — — ');
  }
  dispose() {
    print(' — — — — -APP BLOC DISPOSE — — — — — -');
    _theme.close();
  }
}