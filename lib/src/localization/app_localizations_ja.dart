// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get bindingPhraseLabel => 'バインディングフレーズ';

  @override
  String get networkSsidLabel => 'Wi-Fi SSID';

  @override
  String get flashingButtonLabel => 'フラッシュ';

  @override
  String get packetRateLabel => 'パケットレート';

  @override
  String get baudRateLabel => 'ボーレート';

  @override
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  ) {
    return '$radioMaster または $betaFPV ハードウェアの $expressLRS ファームウェアを更新しています...';
  }
}
