import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('uk'),
  ];

  /// Label for the unique passkey used to generate the UID for radio transmitter/receiver binding. Related to CRITICAL-003 logic consolidation.
  ///
  /// In en, this message translates to:
  /// **'Binding Phrase'**
  String get bindingPhraseLabel;

  /// The name of the wireless network used for OTA (Over-The-Air) flashing.
  ///
  /// In en, this message translates to:
  /// **'WiFi SSID'**
  String get networkSsidLabel;

  /// Action button to begin writing firmware to the target device. Do not translate as 'light flash'.
  ///
  /// In en, this message translates to:
  /// **'Flash'**
  String get flashingButtonLabel;

  /// RF performance setting (Hz). Do not translate technical units or abbreviations.
  ///
  /// In en, this message translates to:
  /// **'Packet Rate'**
  String get packetRateLabel;

  /// Serial communication speed in bits per second. Do not translate the word 'Baud'.
  ///
  /// In en, this message translates to:
  /// **'Baud Rate'**
  String get baudRateLabel;

  /// Status message for firmware updates with immutable brand placeholders.
  ///
  /// In en, this message translates to:
  /// **'Updating {expressLRS} firmware on {radioMaster} or {betaFPV} hardware...'**
  String brandUpdateMessage(
    String expressLRS,
    String radioMaster,
    String betaFPV,
  );

  /// No description provided for @flashDeviceLabel.
  ///
  /// In en, this message translates to:
  /// **'Flash Device'**
  String get flashDeviceLabel;

  /// No description provided for @deviceConfigLabel.
  ///
  /// In en, this message translates to:
  /// **'Device Config'**
  String get deviceConfigLabel;

  /// No description provided for @firmwareManagerLabel.
  ///
  /// In en, this message translates to:
  /// **'Firmware Manager'**
  String get firmwareManagerLabel;

  /// No description provided for @settingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsLabel;

  /// No description provided for @helpSupportLabel.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupportLabel;

  /// No description provided for @noDeviceFoundLabel.
  ///
  /// In en, this message translates to:
  /// **'No Device Found'**
  String get noDeviceFoundLabel;

  /// No description provided for @retryLabel.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryLabel;

  /// No description provided for @manualConnectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Manual Connection'**
  String get manualConnectionLabel;

  /// No description provided for @manualIpOverrideLabel.
  ///
  /// In en, this message translates to:
  /// **'Manual IP Override'**
  String get manualIpOverrideLabel;

  /// No description provided for @connectLabel.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connectLabel;

  /// No description provided for @cancelLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelLabel;

  /// No description provided for @matchedLabel.
  ///
  /// In en, this message translates to:
  /// **'Matched'**
  String get matchedLabel;

  /// No description provided for @mismatchLabel.
  ///
  /// In en, this message translates to:
  /// **'Mismatch'**
  String get mismatchLabel;

  /// No description provided for @connectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Connected: {ip}'**
  String connectedLabel(String ip);

  /// No description provided for @flashingWifiCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Flashing & WiFi'**
  String get flashingWifiCategoryLabel;

  /// No description provided for @aboutSupportCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'About & Support'**
  String get aboutSupportCategoryLabel;

  /// No description provided for @advancedCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advancedCategoryLabel;

  /// No description provided for @flashingDefaultsSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Flashing Defaults'**
  String get flashingDefaultsSectionLabel;

  /// No description provided for @default24GHzDomainLabel.
  ///
  /// In en, this message translates to:
  /// **'Default 2.4GHz Domain'**
  String get default24GHzDomainLabel;

  /// No description provided for @defaultSubGHzDomainLabel.
  ///
  /// In en, this message translates to:
  /// **'Default Sub-GHz Domain'**
  String get defaultSubGHzDomainLabel;

  /// No description provided for @globalBindingPhraseLabel.
  ///
  /// In en, this message translates to:
  /// **'Global Binding Phrase'**
  String get globalBindingPhraseLabel;

  /// No description provided for @homeWifiSsidLabel.
  ///
  /// In en, this message translates to:
  /// **'Home WiFi SSID'**
  String get homeWifiSsidLabel;

  /// No description provided for @homeWifiPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Home WiFi Password'**
  String get homeWifiPasswordLabel;

  /// No description provided for @manageCachedFirmwareLabel.
  ///
  /// In en, this message translates to:
  /// **'Manage Cached Firmware'**
  String get manageCachedFirmwareLabel;

  /// No description provided for @downloadOrDeleteOfflineFirmwareLabel.
  ///
  /// In en, this message translates to:
  /// **'Download or delete offline firmware'**
  String get downloadOrDeleteOfflineFirmwareLabel;

  /// No description provided for @maxCachedVersionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Cached Versions'**
  String get maxCachedVersionsLabel;

  /// No description provided for @clearFirmwareCacheLabel.
  ///
  /// In en, this message translates to:
  /// **'Clear Firmware Cache'**
  String get clearFirmwareCacheLabel;

  /// No description provided for @deleteAllDownloadedFirmwareFilesLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete all downloaded firmware files'**
  String get deleteAllDownloadedFirmwareFilesLabel;

  /// No description provided for @clearLabel.
  ///
  /// In en, this message translates to:
  /// **'CLEAR'**
  String get clearLabel;

  /// No description provided for @aboutSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutSectionLabel;

  /// No description provided for @appVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersionLabel;

  /// No description provided for @legalLicenseLabel.
  ///
  /// In en, this message translates to:
  /// **'Legal & License'**
  String get legalLicenseLabel;

  /// No description provided for @standardDisclaimerAndGplv3Label.
  ///
  /// In en, this message translates to:
  /// **'Standard disclaimer and GPLv3 License'**
  String get standardDisclaimerAndGplv3Label;

  /// No description provided for @developerSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developerSectionLabel;

  /// No description provided for @developerModeEnabledLabel.
  ///
  /// In en, this message translates to:
  /// **'Developer Mode Enabled'**
  String get developerModeEnabledLabel;

  /// No description provided for @testSentryErrorCaptureLabel.
  ///
  /// In en, this message translates to:
  /// **'Test Sentry Error Capture'**
  String get testSentryErrorCaptureLabel;

  /// No description provided for @testSentryErrorCaptureSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sends a test exception to Sentry — check the dashboard'**
  String get testSentryErrorCaptureSubtitle;

  /// No description provided for @shareAnalyticsLabel.
  ///
  /// In en, this message translates to:
  /// **'Share Analytics'**
  String get shareAnalyticsLabel;

  /// No description provided for @shareAnalyticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help improve the app by sharing anonymous usage data'**
  String get shareAnalyticsSubtitle;

  /// No description provided for @expertModeLabel.
  ///
  /// In en, this message translates to:
  /// **'Expert Mode'**
  String get expertModeLabel;

  /// No description provided for @expertModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable advanced firmware handling and downloads'**
  String get expertModeSubtitle;

  /// No description provided for @exportElrsLuaScriptLabel.
  ///
  /// In en, this message translates to:
  /// **'Export ELRS Lua Script'**
  String get exportElrsLuaScriptLabel;

  /// No description provided for @exportElrsLuaScriptSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save elrs.lua for EdgeTX/OpenTX radios'**
  String get exportElrsLuaScriptSubtitle;

  /// No description provided for @submitDebugReportLabel.
  ///
  /// In en, this message translates to:
  /// **'Submit Debug Report to Sentry'**
  String get submitDebugReportLabel;

  /// No description provided for @submitDebugReportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help us fix bugs by sharing anonymous system logs'**
  String get submitDebugReportSubtitle;

  /// No description provided for @clearFirmwareCacheTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Firmware Cache?'**
  String get clearFirmwareCacheTitle;

  /// No description provided for @clearFirmwareCacheMessage.
  ///
  /// In en, this message translates to:
  /// **'This will delete all downloaded firmware zip files. You will need to re-download them if you want to flash offline.'**
  String get clearFirmwareCacheMessage;

  /// No description provided for @clearAllLabel.
  ///
  /// In en, this message translates to:
  /// **'CLEAR ALL'**
  String get clearAllLabel;

  /// No description provided for @submitDebugReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Submit Debug Report'**
  String get submitDebugReportTitle;

  /// No description provided for @submitDebugReportMessage.
  ///
  /// In en, this message translates to:
  /// **'This will send your device info and app logs to Sentry for debugging. No personal info like Binding Phrases or WiFi passwords will be included.'**
  String get submitDebugReportMessage;

  /// No description provided for @describeIssueHint.
  ///
  /// In en, this message translates to:
  /// **'Please describe the issue you are experiencing...'**
  String get describeIssueHint;

  /// No description provided for @proceedLabel.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceedLabel;

  /// No description provided for @submittingReportProgress.
  ///
  /// In en, this message translates to:
  /// **'Submitting report…'**
  String get submittingReportProgress;

  /// No description provided for @saveLabel.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveLabel;

  /// No description provided for @notSetLabel.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSetLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'uk',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
