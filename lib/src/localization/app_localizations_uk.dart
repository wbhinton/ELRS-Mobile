// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Фраза прив\'язки';

  @override
  String get networkSsidLabel => 'SSID Wi-Fi';

  @override
  String get flashingButtonLabel => 'Прошити';

  @override
  String get packetRateLabel => 'Частота пакетів';

  @override
  String get baudRateLabel => 'Швидкість Бод';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Оновлення прошивки $expressLRS на обладнанні $radioMaster або $betaFPV...';
  }
}
