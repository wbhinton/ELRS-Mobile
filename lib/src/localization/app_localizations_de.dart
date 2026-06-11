// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Bindungsphrase';

  @override
  String get networkSsidLabel => 'WLAN-SSID';

  @override
  String get flashingButtonLabel => 'Flashen';

  @override
  String get packetRateLabel => 'Paketrate';

  @override
  String get baudRateLabel => 'Baudrate';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Aktualisiere $expressLRS-Firmware auf $radioMaster- oder $betaFPV-Hardware...';
  }
}
