// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Phrase d\'appairage';

  @override
  String get networkSsidLabel => 'SSID Wi-Fi';

  @override
  String get flashingButtonLabel => 'Flasher';

  @override
  String get packetRateLabel => 'Taux de paquets';

  @override
  String get baudRateLabel => 'Débit Baud';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Mise à jour du firmware $expressLRS sur le matériel $radioMaster ou $betaFPV...';
  }
}
