import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsImpl {
  final SharedPreferences prefs;
  SharedPrefsImpl(this.prefs);

  ///
  /// KEYS
  ///
  static const String keyLocale = 'KEY_LOCALE';



  ///
  /// LOCALE
  ///
  String getLocale() {
    return prefs.getString(keyLocale ,) ?? 'en';
  }

  Future<bool> setLocale(String locale) {
    return prefs.setString(keyLocale, locale);
  }


  

}
