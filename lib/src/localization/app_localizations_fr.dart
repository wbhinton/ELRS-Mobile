// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Binding Phrase';

  @override
  String get networkSsidLabel => 'WiFi SSID';

  @override
  String get flashingButtonLabel => 'Flash';

  @override
  String get packetRateLabel => 'Packet Rate';

  @override
  String get baudRateLabel => 'Baud Rate';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Updating $expressLRS firmware on $radioMaster or $betaFPV hardware...';
  }
}
