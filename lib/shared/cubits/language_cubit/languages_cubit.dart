import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'languages_states.dart';

class LanguagesCubit extends Cubit<LanguagesStates> {
  LanguagesCubit() : super(ChangeLanguageIdle());
  static LanguagesCubit get(context) => BlocProvider.of(context);
  Locale locale =
      const Locale('ar');
  void changeLanguage(String languageCode) {
    locale = Locale(languageCode);
    //ConstantHelper.languageCode = languageCode;
    // CacheHelper.saveDate(
    //     key: ConstantHelper.languageCode, value: locale.languageCode);
    emit(ChangeLanguage());
  }
}
