import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_cs.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_th.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_zh.dart';

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
    Locale('cs'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('nb'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('sv'),
    Locale('th'),
    Locale('uk'),
    Locale('zh'),
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

  /// No description provided for @supportDevelopmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Support Development'**
  String get supportDevelopmentLabel;

  /// No description provided for @supportDevelopmentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Support the developer via Ko-fi'**
  String get supportDevelopmentSubtitle;

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

  /// No description provided for @languageOverrideLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageOverrideLabel;

  /// No description provided for @languageOverrideSystemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get languageOverrideSystemDefault;

  /// No description provided for @legalNoticeSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Legal Notice'**
  String get legalNoticeSectionTitle;

  /// No description provided for @legalNoticeSectionText.
  ///
  /// In en, this message translates to:
  /// **'ELRS Mobile is a free and open-source (FOSS) project developed independently by Weston Hinton. This project is not an official product of ExpressLRS LLC and is not officially supported, endorsed, or certified by the ExpressLRS development team.'**
  String get legalNoticeSectionText;

  /// No description provided for @trademarkNoticeSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Trademark Notice'**
  String get trademarkNoticeSectionTitle;

  /// No description provided for @trademarkNoticeSectionText.
  ///
  /// In en, this message translates to:
  /// **'ExpressLRS and the ExpressLRS logo are trademarks of ExpressLRS LLC. Use of these marks is for descriptive and compatibility purposes only. For the official ExpressLRS configurator and documentation, please visit expresslrs.org.'**
  String get trademarkNoticeSectionText;

  /// No description provided for @officialSupportSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Official Support'**
  String get officialSupportSectionTitle;

  /// No description provided for @officialSupportSectionText.
  ///
  /// In en, this message translates to:
  /// **'Support the official ExpressLRS project: '**
  String get officialSupportSectionText;

  /// No description provided for @donateOpenCollectiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Donate via Open Collective'**
  String get donateOpenCollectiveLabel;

  /// No description provided for @softwareLicenseSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Software License'**
  String get softwareLicenseSectionTitle;

  /// No description provided for @gplv3NoticeText.
  ///
  /// In en, this message translates to:
  /// **'This project is licensed under the GNU General Public License v3.0.'**
  String get gplv3NoticeText;

  /// No description provided for @tabFlashingGuide.
  ///
  /// In en, this message translates to:
  /// **'Flashing Guide'**
  String get tabFlashingGuide;

  /// No description provided for @tabFaq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get tabFaq;

  /// No description provided for @tabResources.
  ///
  /// In en, this message translates to:
  /// **'Resources'**
  String get tabResources;

  /// No description provided for @resourceCommunitySupport.
  ///
  /// In en, this message translates to:
  /// **'Community & Support'**
  String get resourceCommunitySupport;

  /// No description provided for @resourceDiscordCommunity.
  ///
  /// In en, this message translates to:
  /// **'Discord Community'**
  String get resourceDiscordCommunity;

  /// No description provided for @resourceJoinDiscord.
  ///
  /// In en, this message translates to:
  /// **'Join the ELRS Discord'**
  String get resourceJoinDiscord;

  /// No description provided for @resourceGithubRepo.
  ///
  /// In en, this message translates to:
  /// **'GitHub Repository'**
  String get resourceGithubRepo;

  /// No description provided for @resourceFlashRecovery.
  ///
  /// In en, this message translates to:
  /// **'Flash Recovery'**
  String get resourceFlashRecovery;

  /// No description provided for @resourceDeviceUnresponsiveInfo.
  ///
  /// In en, this message translates to:
  /// **'If your device appears unresponsive after a failed flash:'**
  String get resourceDeviceUnresponsiveInfo;

  /// No description provided for @resourceRecoveryStep1.
  ///
  /// In en, this message translates to:
  /// **'Hold the BOOT button while plugging in via USB to enter bootloader mode.'**
  String get resourceRecoveryStep1;

  /// No description provided for @resourceRecoveryStep2.
  ///
  /// In en, this message translates to:
  /// **'Use the ELRS Web Flasher at expresslrs.org/flasher to re-flash over USB/UART.'**
  String get resourceRecoveryStep2;

  /// No description provided for @resourceRecoveryStep3.
  ///
  /// In en, this message translates to:
  /// **'For WiFi-capable devices, hold BOOT for 60 seconds to trigger WiFi Hotspot recovery mode.'**
  String get resourceRecoveryStep3;

  /// No description provided for @resourceRecoveryStep4.
  ///
  /// In en, this message translates to:
  /// **'Join #help on the ELRS Discord — the community can usually recover any device.'**
  String get resourceRecoveryStep4;

  /// No description provided for @resourceBardwellGuideRecommended.
  ///
  /// In en, this message translates to:
  /// **'Joshua Bardwell\'s unbricking guide is highly recommended:'**
  String get resourceBardwellGuideRecommended;

  /// No description provided for @resourceWebFlasherButton.
  ///
  /// In en, this message translates to:
  /// **'Web Flasher'**
  String get resourceWebFlasherButton;

  /// No description provided for @resourceRecoveryVideoButton.
  ///
  /// In en, this message translates to:
  /// **'Recovery Video'**
  String get resourceRecoveryVideoButton;

  /// No description provided for @resourceLegalLiability.
  ///
  /// In en, this message translates to:
  /// **'Legal & Liability'**
  String get resourceLegalLiability;

  /// No description provided for @resourceLiabilityDisclaimerText.
  ///
  /// In en, this message translates to:
  /// **'ELRS Mobile is provided as-is, without warranty of any kind. The developers are not responsible for any damage, data loss, or non-functional hardware resulting from the use of this application, including but not limited to bricked receivers, transmitters, or flight controllers.\n\nBy using this app you accept full responsibility for your hardware.'**
  String get resourceLiabilityDisclaimerText;

  /// No description provided for @resourceViewFullDisclaimerButton.
  ///
  /// In en, this message translates to:
  /// **'View Full Disclaimer'**
  String get resourceViewFullDisclaimerButton;

  /// No description provided for @disclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Use at Your Own Risk'**
  String get disclaimerTitle;

  /// No description provided for @disclaimerHeader.
  ///
  /// In en, this message translates to:
  /// **'ELRS Mobile is provided as-is, without warranty of any kind.'**
  String get disclaimerHeader;

  /// No description provided for @disclaimerLiability.
  ///
  /// In en, this message translates to:
  /// **'The developers are not responsible for any damage, data loss, or non-functional hardware resulting from the use of this application, including but not limited to bricked receivers, transmitters, or flight controllers.'**
  String get disclaimerLiability;

  /// No description provided for @disclaimerAgreement.
  ///
  /// In en, this message translates to:
  /// **'By using this app you confirm that you understand the risks of flashing custom firmware and accept full responsibility for your hardware.'**
  String get disclaimerAgreement;

  /// No description provided for @disclaimerVerification.
  ///
  /// In en, this message translates to:
  /// **'Always verify the target and firmware version before flashing. Keep a record of your original firmware if possible.'**
  String get disclaimerVerification;

  /// No description provided for @disclaimerUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I Understand'**
  String get disclaimerUnderstand;

  /// No description provided for @optionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Firmware Options'**
  String get optionsTitle;

  /// No description provided for @optionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure binding and network credentials.'**
  String get optionsSubtitle;

  /// No description provided for @wifiPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'WiFi Password'**
  String get wifiPasswordLabel;

  /// Time in seconds before the device enters WiFi mode if no connection is found.
  ///
  /// In en, this message translates to:
  /// **'WiFi Auto-On Interval'**
  String get wifiOnIntervalLabel;

  /// No description provided for @regulatoryDomainLabel.
  ///
  /// In en, this message translates to:
  /// **'Regulatory Domain'**
  String get regulatoryDomainLabel;

  /// No description provided for @regDomainIsm.
  ///
  /// In en, this message translates to:
  /// **'ISM (2.4GHz)'**
  String get regDomainIsm;

  /// No description provided for @regDomainEuLbt.
  ///
  /// In en, this message translates to:
  /// **'EU CE (2.4GHz LBT)'**
  String get regDomainEuLbt;

  /// No description provided for @regDomainAu915.
  ///
  /// In en, this message translates to:
  /// **'AU (915MHz)'**
  String get regDomainAu915;

  /// No description provided for @regDomainFcc915.
  ///
  /// In en, this message translates to:
  /// **'FCC (915MHz)'**
  String get regDomainFcc915;

  /// No description provided for @regDomainEu868.
  ///
  /// In en, this message translates to:
  /// **'EU (868MHz)'**
  String get regDomainEu868;

  /// No description provided for @regDomainIn866.
  ///
  /// In en, this message translates to:
  /// **'IN (866MHz)'**
  String get regDomainIn866;

  /// No description provided for @regDomainAu433.
  ///
  /// In en, this message translates to:
  /// **'AU (433MHz)'**
  String get regDomainAu433;

  /// No description provided for @regDomainEu433.
  ///
  /// In en, this message translates to:
  /// **'EU (433MHz)'**
  String get regDomainEu433;

  /// No description provided for @regDomainUs433.
  ///
  /// In en, this message translates to:
  /// **'US (433MHz)'**
  String get regDomainUs433;
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
    'cs',
    'de',
    'en',
    'es',
    'fr',
    'id',
    'it',
    'ja',
    'ko',
    'nb',
    'nl',
    'pl',
    'pt',
    'ru',
    'sv',
    'th',
    'uk',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'cs':
      return AppLocalizationsCs();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'nb':
      return AppLocalizationsNb();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'sv':
      return AppLocalizationsSv();
    case 'th':
      return AppLocalizationsTh();
    case 'uk':
      return AppLocalizationsUk();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
