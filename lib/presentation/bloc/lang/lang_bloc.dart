import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:reciply/data/repository/lang_reposirory.dart';
import 'lang_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  String lang = 'en';

  static const String arabic = 'ar';
  static const String english = 'en';
  final LanguageRepository langRepository;

  LanguageCubit(this.langRepository) : super(LanguageInitial());

  Future<void> getLanguage() async {
    // if (event is AppStart) {
    emit(LanguageLoading());
    String? result = await langRepository.hasLang();
    lang = result ?? 'ar';
    emit(LanguageChanged(language: result ?? "ar"));
  }

  Future<void> changeLanguage(String newLang) async {
    emit(LanguageLoading());
    lang = newLang;
    await langRepository.saveLang(newLang);
    emit(LanguageChanged(language: newLang));
  }
}
