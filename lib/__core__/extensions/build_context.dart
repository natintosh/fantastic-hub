import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationX on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this);

  List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  List<LocalizationsDelegate> get delegates =>
      AppLocalizations.localizationsDelegates;
}

extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension MediaQueryX on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);
}
