import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageRepository {
  final String LANGUAGE = 'Language';

  Future<void> saveLang(String lang) async {
    /// write to keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(LANGUAGE, lang);
  }

  Future<String?> hasLang() async {
    /// read from keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(LANGUAGE);
  }
}
