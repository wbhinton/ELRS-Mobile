// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get bindingPhraseLabel => 'Frase de Vinculación';

  @override
  String get networkSsidLabel => 'SSID de WiFi';

  @override
  String get flashingButtonLabel => 'Flashear';

  @override
  String get packetRateLabel => 'Tasa de Paquetes';

  @override
  String get baudRateLabel => 'Tasa de Baudios';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return 'Actualizando firmware de $expressLRS en hardware $radioMaster o $betaFPV...';
  }
}
