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

  /// Progress label shown briefly while the app checks whether the firmware is already cached locally, before deciding whether to unpack it from cache or download it. This app is designed for fully offline use, so this is normally instantaneous.
  ///
  /// In en, this message translates to:
  /// **'Locating Firmware'**
  String get flashingStatusLocating;

  /// Progress label shown while firmware is being extracted from the locally cached archive. This is the normal, offline path most users hit — do not translate as network activity.
  ///
  /// In en, this message translates to:
  /// **'Unpacking Firmware'**
  String get flashingStatusUnpacking;

  /// Progress label shown only when the firmware is NOT already cached locally and must be fetched over the network. This is the fallback/rare path, not the normal offline flow — do not use this label for reading cached files.
  ///
  /// In en, this message translates to:
  /// **'Downloading Firmware'**
  String get flashingStatusDownloading;

  /// Progress label shown while the firmware binary is being patched/assembled with the user's settings (binding phrase, WiFi, regulatory domain) before upload.
  ///
  /// In en, this message translates to:
  /// **'Building Firmware'**
  String get flashingStatusBuilding;

  /// Progress label shown while the firmware is being transferred to the device over WiFi.
  ///
  /// In en, this message translates to:
  /// **'Uploading to Device'**
  String get flashingStatusUploading;

  /// Progress label shown after the upload finishes, while the device erases/writes its flash memory. There is no progress signal from the device during this step, so this message tells the user the app has not frozen.
  ///
  /// In en, this message translates to:
  /// **'Writing to Device — Please Wait'**
  String get flashingStatusFinalizing;

  /// Dashboard button that opens the screen for writing (flashing) new firmware onto a device. 'Flash' means installing firmware, not a camera flash.
  ///
  /// In en, this message translates to:
  /// **'Flash Device'**
  String get flashDeviceLabel;

  /// Dashboard button that opens the connected device's own configuration web page.
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

  /// Button that searches for the ExpressLRS device on the network again.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryLabel;

  /// No description provided for @manualConnectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Manual Connection'**
  String get manualConnectionLabel;

  /// Title for entering the device's IP address by hand instead of discovering it automatically.
  ///
  /// In en, this message translates to:
  /// **'Manual IP Override'**
  String get manualIpOverrideLabel;

  /// Button that connects to a device at a manually entered IP address.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connectLabel;

  /// Generic dialog button that dismisses without making changes.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelLabel;

  /// Short status badge: the firmware target selected in the app matches the connected device's hardware.
  ///
  /// In en, this message translates to:
  /// **'Matched'**
  String get matchedLabel;

  /// Short status badge: the firmware target selected in the app does NOT match the connected device's hardware.
  ///
  /// In en, this message translates to:
  /// **'Mismatch'**
  String get mismatchLabel;

  /// No description provided for @connectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Connected: {ip}'**
  String connectedLabel(String ip);

  /// Setting for the radio regulatory domain applied by default to 2.4GHz devices.
  ///
  /// In en, this message translates to:
  /// **'Default 2.4GHz Domain'**
  String get default24GHzDomainLabel;

  /// Setting for the radio regulatory domain applied by default to sub-GHz (900MHz-band) devices.
  ///
  /// In en, this message translates to:
  /// **'Default Sub-GHz Domain'**
  String get defaultSubGHzDomainLabel;

  /// Setting for the default binding phrase: the shared secret that pairs an ExpressLRS transmitter and receiver.
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

  /// Button that deletes all cached firmware files. Keep it short; it is uppercase in the source.
  ///
  /// In en, this message translates to:
  /// **'CLEAR'**
  String get clearLabel;

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

  /// Setting that unlocks advanced features such as saving firmware binaries.
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

  /// Confirmation button in the dialog that deletes all cached firmware files. Uppercase in the source.
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

  /// Dialog button that continues with the action despite a warning.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceedLabel;

  /// No description provided for @submittingReportProgress.
  ///
  /// In en, this message translates to:
  /// **'Submitting report…'**
  String get submittingReportProgress;

  /// Generic dialog button that saves the entered value.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveLabel;

  /// Shown under a setting that has no value yet.
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

  /// Tab label for Frequently Asked Questions. Use the common local abbreviation if there is one.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get tabFaq;

  /// Tab label for links to community help, recovery guides and legal information.
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

  /// Heading for instructions on recovering a device whose firmware update failed.
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

  /// Button opening the official ExpressLRS Web Flasher website. 'Web Flasher' is a product name.
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

  /// Button acknowledging the risk disclaimer before using the app.
  ///
  /// In en, this message translates to:
  /// **'I Understand'**
  String get disclaimerUnderstand;

  /// Heading of the card with settings baked into the firmware (binding phrase, WiFi credentials, regulatory domain).
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

  /// Regulatory domain option. Region codes, frequencies and 'ISM'/'LBT'/'CE'/'FCC' are standard identifiers and should normally stay as-is.
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

  /// Progress label shown after a firmware binary was saved to the phone instead of flashed.
  ///
  /// In en, this message translates to:
  /// **'Firmware Saved'**
  String get flashingStatusSaved;

  /// Error shown when the user taps Flash without choosing which hardware target to build firmware for.
  ///
  /// In en, this message translates to:
  /// **'Please select a target device.'**
  String get flashErrorNoTarget;

  /// Error shown when the user taps Flash without choosing an ExpressLRS firmware version.
  ///
  /// In en, this message translates to:
  /// **'Please select a firmware version.'**
  String get flashErrorNoVersion;

  /// Error shown when the user taps Flash but the phone is not connected to an ExpressLRS receiver or transmitter over WiFi.
  ///
  /// In en, this message translates to:
  /// **'Cannot flash: no ELRS device connected.'**
  String get flashErrorNoDevice;

  /// Error shown when the selected firmware target uses a different microcontroller chip than the connected device, so it can never work. The placeholders are chip names such as ESP32 or ESP8285 and must not be translated.
  ///
  /// In en, this message translates to:
  /// **'Incompatible chip: this firmware is built for {targetChip}, but the connected device is {deviceChip}. Select a target for the same chip.'**
  String flashErrorChipMismatch(String targetChip, String deviceChip);

  /// Error shown when flashing needs firmware files that are not cached and cannot be downloaded, usually because the phone is joined to the device's own WiFi hotspot. 'Firmware Manager' is the name of a screen in the app.
  ///
  /// In en, this message translates to:
  /// **'No internet access to fetch missing files. Please disconnect from the ELRS device, download this firmware via the Firmware Manager to complete your cache, and try again.'**
  String get flashErrorOfflineFlash;

  /// Error shown when saving a firmware binary needs files that are not cached and the phone has no internet, usually because it is joined to the device's WiFi hotspot. 'Firmware Manager' is the name of a screen in the app.
  ///
  /// In en, this message translates to:
  /// **'No internet access. You cannot download firmware while connected to the ELRS device hotspot. Please disconnect, download this version via the Firmware Manager, and try again.'**
  String get flashErrorOfflineDownload;

  /// Headline shown when a flash attempt fails. The technical reason from the device is shown untranslated underneath.
  ///
  /// In en, this message translates to:
  /// **'Flashing failed.'**
  String get flashErrorFlashFailed;

  /// Warning shown when all firmware was sent but the device disconnected without confirming success, so the result is unknown. 'Device Config' is the name of a screen in the app.
  ///
  /// In en, this message translates to:
  /// **'The device disconnected before confirming the flash, so it may not have completed. This happens if it loses power or restarts mid-flash, and occasionally on a weak WiFi link after a successful flash. Check the firmware version in Device Config, and flash again if it hasn\'t changed.'**
  String get flashErrorUnconfirmed;

  /// Headline shown when building or saving a firmware binary fails. The technical reason is shown untranslated underneath.
  ///
  /// In en, this message translates to:
  /// **'Failed to download firmware.'**
  String get flashErrorDownloadFailed;

  /// Validation error under the WiFi network name (SSID) field.
  ///
  /// In en, this message translates to:
  /// **'SSID must be 32 characters or less'**
  String get validationSsidTooLong;

  /// Validation error under the WiFi password field.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get validationPasswordTooShort;

  /// Validation error under the WiFi password field.
  ///
  /// In en, this message translates to:
  /// **'Password must be 63 characters or less'**
  String get validationPasswordTooLong;

  /// Title of the warning dialog shown when the selected firmware target's product name differs from the product running on the connected device.
  ///
  /// In en, this message translates to:
  /// **'Target Mismatch'**
  String get targetMismatchTitle;

  /// Body of the target mismatch warning dialog. 'Force flash' means flashing anyway, overriding the safety check.
  ///
  /// In en, this message translates to:
  /// **'The selected firmware target does not match the hardware currently running on the device. Are you sure you want to force flash?'**
  String get targetMismatchMessage;

  /// Dangerous dialog button that flashes firmware even though the target does not match the device, overriding the safety check. Displayed in uppercase.
  ///
  /// In en, this message translates to:
  /// **'Force Flash'**
  String get forceFlashLabel;

  /// Title of the dialog asking whether to flash without a binding phrase. A binding phrase is the shared secret that pairs an ExpressLRS transmitter and receiver.
  ///
  /// In en, this message translates to:
  /// **'No Binding Phrase'**
  String get noBindPhraseTitle;

  /// Body of the dialog asking whether to flash without a binding phrase.
  ///
  /// In en, this message translates to:
  /// **'No binding phrase set. Proceed with the default (empty)?'**
  String get noBindPhraseMessage;

  /// Brief pop-up notification after firmware was flashed to the device.
  ///
  /// In en, this message translates to:
  /// **'Flashing completed successfully!'**
  String get flashSuccessSnackbar;

  /// Brief pop-up notification after a firmware binary was saved to the phone.
  ///
  /// In en, this message translates to:
  /// **'Firmware saved successfully!'**
  String get firmwareSavedSnackbar;

  /// Message shown on the flashing screen after a successful flash while the device restarts.
  ///
  /// In en, this message translates to:
  /// **'Flashing Successful! Device is rebooting.'**
  String get flashSuccessMessage;

  /// Warning shown when the selected target uses an STM32 chip, which cannot be flashed over WiFi. OTA means over-the-air. STLink and Betaflight Passthrough are product names and must not be translated.
  ///
  /// In en, this message translates to:
  /// **'STM32 Target Selected: OTA flashing is not supported for this hardware. You can build and save this firmware locally to flash manually via STLink or Betaflight Passthrough.'**
  String get stm32OtaWarning;

  /// Button that builds the firmware and saves the file to the phone instead of flashing it. Displayed in uppercase.
  ///
  /// In en, this message translates to:
  /// **'Download Binary'**
  String get downloadBinaryLabel;

  /// Label on the main flash button while no ExpressLRS device is connected. Displayed in uppercase.
  ///
  /// In en, this message translates to:
  /// **'Waiting for Device...'**
  String get waitingForDeviceLabel;

  /// Label on the disabled flash button when the target cannot be flashed over WiFi (over-the-air). Displayed in uppercase.
  ///
  /// In en, this message translates to:
  /// **'OTA Unavailable'**
  String get otaUnavailableLabel;

  /// Label on the main button after a successful flash; tapping it resets the screen. Displayed in uppercase.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneLabel;

  /// Heading of the card where the user picks which hardware to build firmware for.
  ///
  /// In en, this message translates to:
  /// **'Target Selection'**
  String get targetSelectionTitle;

  /// Dropdown label for choosing transmitter (TX) or receiver (RX).
  ///
  /// In en, this message translates to:
  /// **'Device Type'**
  String get deviceTypeLabel;

  /// Dropdown label for choosing the hardware manufacturer.
  ///
  /// In en, this message translates to:
  /// **'Device Vendor'**
  String get deviceVendorLabel;

  /// Dropdown label for choosing the radio frequency band, e.g. 2.4GHz or 900MHz.
  ///
  /// In en, this message translates to:
  /// **'Regulatory & Frequency'**
  String get regulatoryFrequencyLabel;

  /// Dropdown label for choosing the exact hardware model the firmware is built for.
  ///
  /// In en, this message translates to:
  /// **'Device Target'**
  String get deviceTargetLabel;

  /// Button shown when no firmware versions are cached on the phone; opens the Firmware Manager screen.
  ///
  /// In en, this message translates to:
  /// **'No firmware downloaded. Go to Firmware Manager'**
  String get noFirmwareDownloadedButton;

  /// Warning shown when the selected hardware needs a newer firmware version than any cached on the phone.
  ///
  /// In en, this message translates to:
  /// **'Hardware requires v{version} or newer.'**
  String hardwareRequiresVersion(String version);

  /// Button that opens the Firmware Manager to download a firmware version supported by the selected hardware.
  ///
  /// In en, this message translates to:
  /// **'Download Compatible Firmware'**
  String get downloadCompatibleFirmwareButton;

  /// Dropdown label for choosing which ExpressLRS firmware version to flash.
  ///
  /// In en, this message translates to:
  /// **'Firmware Version'**
  String get firmwareVersionLabel;

  /// Helper text under the firmware version dropdown.
  ///
  /// In en, this message translates to:
  /// **'Select the ELRS version to flash'**
  String get firmwareVersionHelper;

  /// Small tag next to a firmware version meaning it is stored on the phone and available offline.
  ///
  /// In en, this message translates to:
  /// **'(Cached)'**
  String get cachedBadge;

  /// Error shown when the list of firmware versions cannot be loaded. The placeholder is a technical error message.
  ///
  /// In en, this message translates to:
  /// **'Error loading versions: {error}'**
  String errorLoadingVersions(String error);

  /// Dropdown label for choosing a saved set of flashing options (binding phrase, WiFi credentials).
  ///
  /// In en, this message translates to:
  /// **'Flashing Profile'**
  String get flashingProfileLabel;

  /// Tooltip on the button that creates a new flashing profile.
  ///
  /// In en, this message translates to:
  /// **'Add Profile'**
  String get addProfileTooltip;

  /// Tooltip on the button that deletes the selected flashing profile.
  ///
  /// In en, this message translates to:
  /// **'Delete Profile'**
  String get deleteProfileTooltip;

  /// Helper text under the binding phrase field.
  ///
  /// In en, this message translates to:
  /// **'Your unique binding phrase'**
  String get bindingPhraseHelper;

  /// Title of the dialog for creating a new flashing profile.
  ///
  /// In en, this message translates to:
  /// **'Add Flashing Profile'**
  String get addProfileTitle;

  /// Placeholder in the new profile name field. 'Quads' means quadcopter drones.
  ///
  /// In en, this message translates to:
  /// **'Profile Name (e.g., My Quads)'**
  String get profileNameHint;

  /// Dialog button confirming creation of a new item.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addLabel;

  /// Title of the dialog confirming deletion of a flashing profile.
  ///
  /// In en, this message translates to:
  /// **'Delete Profile'**
  String get deleteProfileTitle;

  /// Body of the dialog confirming deletion of a flashing profile.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the profile \"{name}\"?'**
  String deleteProfileMessage(String name);

  /// Dialog button confirming deletion.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteLabel;

  /// Settings category and section heading for flashing profiles, binding phrase and WiFi credentials.
  ///
  /// In en, this message translates to:
  /// **'Profiles & Network'**
  String get settingsCategoryProfilesNetwork;

  /// Settings category and section heading for firmware cache and app preferences.
  ///
  /// In en, this message translates to:
  /// **'App & Storage'**
  String get settingsCategoryAppStorage;

  /// Settings category heading for expert tools and diagnostics.
  ///
  /// In en, this message translates to:
  /// **'Advanced & Debug'**
  String get settingsCategoryAdvancedDebug;

  /// Settings category and section heading for app version, license and legal notices.
  ///
  /// In en, this message translates to:
  /// **'About & Legal'**
  String get settingsCategoryAboutLegal;

  /// Settings section heading for the default radio regulatory domains applied to new flashes.
  ///
  /// In en, this message translates to:
  /// **'Regulatory Defaults'**
  String get settingsSectionRegulatoryDefaults;

  /// Settings section heading for language and analytics preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsSectionPreferences;

  /// Settings section heading for expert features such as exporting the radio Lua script.
  ///
  /// In en, this message translates to:
  /// **'Power Tools'**
  String get settingsSectionPowerTools;

  /// Settings section heading for debug reporting.
  ///
  /// In en, this message translates to:
  /// **'Diagnostics'**
  String get settingsSectionDiagnostics;

  /// Shown when a stored regulatory domain value is not recognised.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get regDomainUnknown;

  /// How many firmware versions the app keeps cached offline.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 version} other{{count} versions}}'**
  String maxCachedVersionsCount(int count);

  /// Title of the dialog for editing a setting. The placeholder is the setting's already-translated name, e.g. 'Home WiFi SSID'.
  ///
  /// In en, this message translates to:
  /// **'Edit {field}'**
  String editFieldTitle(String field);

  /// Placeholder in the text box of the setting edit dialog. The placeholder is the setting's already-translated name.
  ///
  /// In en, this message translates to:
  /// **'Enter {field}'**
  String enterFieldHint(String field);

  /// Confirmation after exporting the ExpressLRS Lua script file. 'elrs.lua' is a file name and must not be translated.
  ///
  /// In en, this message translates to:
  /// **'elrs.lua saved to device!'**
  String get luaScriptSavedSnackbar;

  /// Error after exporting the Lua script fails. The placeholder is a technical error message.
  ///
  /// In en, this message translates to:
  /// **'Failed to save script: {error}'**
  String luaScriptSaveFailed(String error);

  /// Confirmation after sending a debug report, with the report's short reference ID.
  ///
  /// In en, this message translates to:
  /// **'Submitted! Event ID: {eventId}…'**
  String debugReportSubmittedWithId(String eventId);

  /// Confirmation after sending a debug report.
  ///
  /// In en, this message translates to:
  /// **'Report submitted successfully!'**
  String get debugReportSubmitted;

  /// Error when sending a debug report fails. The placeholder is a technical error message.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit: {error}'**
  String debugReportFailed(String error);

  /// Error when the license text cannot be loaded. The placeholder is a technical error message.
  ///
  /// In en, this message translates to:
  /// **'Error loading license: {error}'**
  String licenseLoadFailed(String error);

  /// Firmware Manager error when the list of versions cannot be loaded. A technical reason is shown untranslated underneath.
  ///
  /// In en, this message translates to:
  /// **'Could not load firmware versions.'**
  String get firmwareErrorLoadFailed;

  /// Firmware Manager error: downloads need internet, which is unavailable while the phone is joined to the ExpressLRS device's own WiFi hotspot.
  ///
  /// In en, this message translates to:
  /// **'Cannot download firmware while connected directly to the receiver\'s WiFi hotspot. Please disconnect or use a home network.'**
  String get firmwareErrorOnHotspot;

  /// Firmware Manager error when the maximum number of offline firmware versions is already stored.
  ///
  /// In en, this message translates to:
  /// **'Cache limit reached. Please delete an old version.'**
  String get firmwareErrorCacheFull;

  /// Firmware Manager error when the download server cannot be contacted.
  ///
  /// In en, this message translates to:
  /// **'Unable to reach the firmware server. Please check your internet connection.'**
  String get firmwareErrorServerUnreachable;

  /// Firmware Manager error when a download stops part-way.
  ///
  /// In en, this message translates to:
  /// **'Download interrupted: the network connection was lost. Please check your connection and try again.'**
  String get firmwareErrorDownloadInterrupted;

  /// Firmware Manager error headline for other download failures. A technical reason is shown untranslated underneath.
  ///
  /// In en, this message translates to:
  /// **'Failed to download firmware.'**
  String get firmwareErrorDownloadFailed;

  /// Firmware Manager error when removing a cached firmware version fails. A technical reason is shown untranslated underneath.
  ///
  /// In en, this message translates to:
  /// **'Could not delete this firmware version.'**
  String get firmwareErrorDeleteFailed;

  /// Row title in the Firmware Manager list.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String firmwareVersionTitle(String version);

  /// Subtitle for a firmware version that is stored on the phone and can be flashed without internet.
  ///
  /// In en, this message translates to:
  /// **'Ready for offline use'**
  String get readyForOfflineUse;

  /// Firmware Manager header showing how much space cached firmware uses, in megabytes.
  ///
  /// In en, this message translates to:
  /// **'Storage Used: {size} MB'**
  String storageUsedMb(double size);

  /// Firmware Manager header showing how many versions are cached out of the allowed maximum.
  ///
  /// In en, this message translates to:
  /// **'{count} / {limit} Versions'**
  String cachedVersionsOfLimit(int count, int limit);

  /// Tagline on the launch screen describing the app. Displayed in uppercase.
  ///
  /// In en, this message translates to:
  /// **'Independent Configuration Tool'**
  String get splashTagline;

  /// Small print on the launch screen. Keep the line break. Version numbers must not be changed.
  ///
  /// In en, this message translates to:
  /// **'Not an official ExpressLRS product.\nCompatible with 3.3.x/4.x firmware.'**
  String get splashDisclaimer;

  /// Name shown for a connected ExpressLRS device that did not report its product name.
  ///
  /// In en, this message translates to:
  /// **'ELRS Device'**
  String get unknownDeviceName;

  /// Shown in place of the device's network address when it is not known.
  ///
  /// In en, this message translates to:
  /// **'Unknown IP'**
  String get unknownIpLabel;

  /// Label for the file type filter (.bin and .gz files) in the file picker used to upload firmware.
  ///
  /// In en, this message translates to:
  /// **'Firmware Binaries'**
  String get firmwareBinariesFileType;

  /// Error when the help and FAQ text cannot be loaded. The placeholder is a technical error message.
  ///
  /// In en, this message translates to:
  /// **'Error loading help content: {error}'**
  String helpContentLoadFailed(String error);
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
