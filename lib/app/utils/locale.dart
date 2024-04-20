import 'package:shared_preferences/shared_preferences.dart';

class LocaleUtil {
  late final SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String getLocale() {
    final String? locale = _prefs.getString('locale');
    if (locale == null) {
      setLocale('en');
      return 'en';
    }
    return locale;
  }

  Future<void> setLocale(String locale) async {
    await _prefs.setString('locale', locale);
  }
}
