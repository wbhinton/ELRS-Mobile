import 'package:cupertino_ui/cupertino_ui.dart' show GlobalCupertinoLocalizations;
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:material_ui/material_ui.dart' show GlobalMaterialLocalizations;

import '../localization/app_localizations.dart';

/// Localization delegates for the app.
///
/// Use this instead of the generated `AppLocalizations.localizationsDelegates`:
/// gen-l10n (as of Flutter 3.50) still emits the deprecated SDK Material and
/// Cupertino delegates, whose types differ from the ones `material_ui` and
/// `cupertino_ui` widgets look up. With the generated list, every non-English
/// locale fails with "No MaterialLocalizations found".
const List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
