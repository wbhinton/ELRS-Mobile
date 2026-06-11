import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:elrs_mobile/src/localization/app_localizations.dart';
import '../../../core/presentation/responsive_layout.dart';
import 'settings_controller.dart';
import 'widgets/settings_master_detail.dart';
import '../../../core/utils/lua_export_utils.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(settingsControllerProvider.notifier);
    final state = ref.watch(settingsControllerProvider);
    final showBindPhrase = useValueNotifier(false);
    final showWifiPassword = useValueNotifier(false);
    final l10n = AppLocalizations.of(context)!;

    useEffect(() {
      Future.microtask(() => controller.loadSettings());
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsLabel)),
      body: SettingsMasterDetail(
        masterBuilder: (context, selected, onSelected) => ListView(
          children: [
            _buildSidebarItem(
              context,
              icon: Icons.flash_on,
              title: l10n.flashingWifiCategoryLabel,
              selected: selected == SettingsCategory.flashing,
              onTap: () => onSelected(SettingsCategory.flashing),
            ),
            _buildSidebarItem(
              context,
              icon: Icons.info_outline,
              title: l10n.aboutSupportCategoryLabel,
              selected: selected == SettingsCategory.about,
              onTap: () => onSelected(SettingsCategory.about),
            ),
            _buildSidebarItem(
              context,
              icon: Icons.settings_suggest,
              title: l10n.advancedCategoryLabel,
              selected: selected == SettingsCategory.advanced,
              onTap: () => onSelected(SettingsCategory.advanced),
            ),
          ],
        ),
        detailBuilder: (context, selected) {
          final isTablet = ResponsiveLayout.isTablet(context);

          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 32.0 : 0.0,
              vertical: 8.0,
            ),
            children: [
              if (!isTablet || selected == SettingsCategory.flashing) ...[
                _buildSectionHeader(context, l10n.flashingDefaultsSectionLabel),
                ListTile(
                  title: Text(l10n.default24GHzDomainLabel),
                  subtitle: Text(_getDomainLabel2400(state.defaultDomain2400)),
                  trailing: DropdownButton<int>(
                    value: state.defaultDomain2400,
                    onChanged: (val) {
                      if (val != null) controller.setDefaultDomain2400(val);
                    },
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('ISM')),
                      DropdownMenuItem(value: 1, child: Text('EU CE LBT')),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(l10n.defaultSubGHzDomainLabel),
                  subtitle: Text(_getDomainLabel900(state.defaultDomain900)),
                  trailing: DropdownButton<int>(
                    value: state.defaultDomain900,
                    onChanged: (val) {
                      if (val != null) controller.setDefaultDomain900(val);
                    },
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('AU915')),
                      DropdownMenuItem(value: 1, child: Text('FCC915')),
                      DropdownMenuItem(value: 2, child: Text('EU868')),
                      DropdownMenuItem(value: 3, child: Text('IN866')),
                      DropdownMenuItem(value: 4, child: Text('AU433')),
                      DropdownMenuItem(value: 5, child: Text('EU433')),
                      DropdownMenuItem(value: 6, child: Text('US433')),
                    ],
                  ),
                ),
                _buildEditDialogTile(
                  context,
                  title: l10n.globalBindingPhraseLabel,
                  currentValue: state.globalBindPhrase,
                  onSaved: (val) => controller.setGlobalBindPhrase(val),
                  isSecret: true,
                  isVisibleNotifier: showBindPhrase,
                ),
                _buildEditDialogTile(
                  context,
                  title: l10n.homeWifiSsidLabel,
                  currentValue: state.homeWifiSsid,
                  onSaved: (val) => controller.setHomeWifiSsid(val),
                ),
                _buildEditDialogTile(
                  context,
                  title: l10n.homeWifiPasswordLabel,
                  currentValue: state.homeWifiPassword,
                  onSaved: (val) => controller.setHomeWifiPassword(val),
                  isSecret: true,
                  isVisibleNotifier: showWifiPassword,
                ),
                ListTile(
                  title: Text(l10n.languageOverrideLabel),
                  subtitle: Text(state.appLocale == null
                      ? l10n.languageOverrideSystemDefault
                      : _getLocaleName(state.appLocale!)),
                  trailing: DropdownButton<String?>(
                    value: state.appLocale,
                    onChanged: (val) {
                      controller.setAppLocale(val);
                    },
                    items: [
                      DropdownMenuItem(
                        value: null,
                        child: Text(l10n.languageOverrideSystemDefault),
                      ),
                      const DropdownMenuItem(value: 'en', child: Text('English')),
                      const DropdownMenuItem(value: 'de', child: Text('Deutsch')),
                      const DropdownMenuItem(value: 'es', child: Text('Español')),
                      const DropdownMenuItem(value: 'fr', child: Text('Français')),
                      const DropdownMenuItem(value: 'ja', child: Text('日本語')),
                      const DropdownMenuItem(value: 'uk', child: Text('Українська')),
                      const DropdownMenuItem(value: 'pt', child: Text('Português')),
                      const DropdownMenuItem(value: 'it', child: Text('Italiano')),
                      const DropdownMenuItem(value: 'pl', child: Text('Polski')),
                      const DropdownMenuItem(value: 'ko', child: Text('한국어')),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(l10n.manageCachedFirmwareLabel),
                  subtitle: Text(l10n.downloadOrDeleteOfflineFirmwareLabel),
                  leading: const Icon(Icons.sd_storage),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => context.push('/firmware_manager'),
                ),
                ListTile(
                  title: Text(l10n.maxCachedVersionsLabel),
                  subtitle: Text('${state.maxCachedVersions} versions'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: state.maxCachedVersions > 1
                            ? () => controller.setMaxCachedVersions(
                                state.maxCachedVersions - 1,
                              )
                            : null,
                      ),
                      Text(
                        '${state.maxCachedVersions}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: state.maxCachedVersions < 10
                            ? () => controller.setMaxCachedVersions(
                                state.maxCachedVersions + 1,
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(l10n.clearFirmwareCacheLabel),
                  subtitle: Text(l10n.deleteAllDownloadedFirmwareFilesLabel),
                  leading: const Icon(Icons.delete_sweep, color: Colors.red),
                  trailing: TextButton(
                    onPressed: () => _showClearCacheDialog(context, controller),
                    child: Text(
                      l10n.clearLabel,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
              if (!isTablet || selected == SettingsCategory.about) ...[
                _buildSectionHeader(context, l10n.aboutSectionLabel),
                ListTile(
                  title: Text(l10n.appVersionLabel),
                  subtitle: Text(state.appVersion),
                  leading: const Icon(Icons.info_outline),
                ),
                ListTile(
                  title: Text(l10n.legalLicenseLabel),
                  subtitle: Text(l10n.standardDisclaimerAndGplv3Label),
                  leading: const Icon(Icons.gavel_outlined),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.push('/legal'),
                ),
              ],
              if (!isTablet || selected == SettingsCategory.advanced) ...[
                if (state.developerMode) ...[
                  _buildSectionHeader(context, l10n.developerSectionLabel),
                  ListTile(title: Text(l10n.developerModeEnabledLabel)),
                  ListTile(
                    title: Text(l10n.testSentryErrorCaptureLabel),
                    subtitle: Text(l10n.testSentryErrorCaptureSubtitle),
                    leading: const Icon(
                      Icons.science,
                      color: Colors.deepPurple,
                    ),
                    trailing: const Icon(Icons.send),
                    onTap: () async {
                      final id = await Sentry.captureException(
                        Exception('Sentry test exception — ignore'),
                        stackTrace: StackTrace.current,
                        withScope: (scope) => scope.setTag('test', 'true'),
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Sent! Event ID: ${id.toString().substring(0, 8)}…',
                            ),
                            backgroundColor: Colors.deepPurple,
                            duration: const Duration(seconds: 6),
                          ),
                        );
                      }
                    },
                  ),
                ],
                _buildSectionHeader(context, l10n.advancedCategoryLabel),
                SwitchListTile(
                  title: Text(l10n.shareAnalyticsLabel),
                  subtitle: Text(l10n.shareAnalyticsSubtitle),
                  value: state.shareAnalytics,
                  onChanged: (val) => controller.setShareAnalytics(val),
                ),
                SwitchListTile(
                  title: Text(l10n.expertModeLabel),
                  subtitle: Text(l10n.expertModeSubtitle),
                  value: state.expertMode,
                  onChanged: (val) => controller.toggleExpertMode(),
                ),
                if (state.expertMode) ...[
                  const Divider(),
                  ListTile(
                    title: Text(l10n.exportElrsLuaScriptLabel),
                    subtitle: Text(l10n.exportElrsLuaScriptSubtitle),
                    leading: const Icon(Icons.code, color: Colors.blue),
                    trailing: const Icon(Icons.save_alt),
                    onTap: () async {
                      try {
                        await LuaExportUtils.exportElrsLuaScript();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('elrs.lua saved to device!'),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to save script: $e')),
                          );
                        }
                      }
                    },
                  ),
                  ListTile(
                    title: Text(l10n.submitDebugReportLabel),
                    subtitle: Text(l10n.submitDebugReportSubtitle),
                    leading: const Icon(Icons.bug_report, color: Colors.orange),
                    trailing: const Icon(Icons.send),
                    onTap: () => _showPrivacyGuard(context, state, ref),
                  ),
                ],
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildSidebarItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: selected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      selected: selected,
      onTap: onTap,
    );
  }

  void _showClearCacheDialog(
    BuildContext context,
    SettingsController controller,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(l10n.clearFirmwareCacheTitle),
        ),
        content: Text(l10n.clearFirmwareCacheMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancelLabel),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              controller.clearCache();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.clearFirmwareCacheLabel)),
              );
            },
            child: Text(l10n.clearAllLabel),
          ),
        ],
      ),
    );
  }

  void _showPrivacyGuard(
    BuildContext context,
    SettingsState state,
    WidgetRef ref,
  ) {
    final descController = TextEditingController();
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(l10n.submitDebugReportTitle),
        ),
        scrollable: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.submitDebugReportMessage),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: l10n.describeIssueHint,
                hintMaxLines: 3,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancelLabel),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: descController,
            builder: (context, value, child) {
              final isEnabled = value.text.trim().isNotEmpty;
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                onPressed: isEnabled
                    ? () async {
                        final desc = descController.text.trim();
                        Navigator.pop(context);
                        _submitReport(context, state, desc, ref);
                      }
                    : null,
                child: Text(l10n.proceedLabel),
              );
            },
          ),
        ],
      ),
    );
  }

  void _submitReport(
    BuildContext context,
    SettingsState state,
    String description,
    WidgetRef ref,
  ) async {
    // Track whether user cancelled so we don't pop an already-popped dialog.
    var dialogDismissed = false;
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Expanded(child: Text(l10n.submittingReportProgress)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              dialogDismissed = true;
              Navigator.pop(ctx);
            },
            child: Text(l10n.cancelLabel),
          ),
        ],
      ),
    );

    try {
      final id = await Sentry.captureMessage(
        description.isNotEmpty
            ? description
            : 'User Feedback: Manual Debug Report',
        level: SentryLevel.info,
        withScope: (scope) {
          scope.transaction = 'Manual Debug Report';
          scope.setTag('user-report', 'manual');
          scope.setTag('app.version', state.appVersion);
          scope.setTag('app.expert_mode', state.expertMode.toString());
          scope.setTag('app.developer_mode', state.developerMode.toString());
          scope.setTag('app.domain_2400', state.defaultDomain2400.toString());
          scope.setTag('app.domain_900', state.defaultDomain900.toString());
          scope.setTag(
            'app.max_cached_versions',
            state.maxCachedVersions.toString(),
          );
          scope.setTag(
            'has_bind_phrase',
            state.globalBindPhrase.isNotEmpty.toString(),
          );
          scope.setTag(
            'has_wifi_ssid',
            state.homeWifiSsid.isNotEmpty.toString(),
          );
        },
      ).timeout(const Duration(seconds: 10));

      if (context.mounted && !dialogDismissed) {
        Navigator.of(context, rootNavigator: true).pop(); // Hide loading dialog

        final msg = id != SentryId.empty()
            ? 'Submitted! Event ID: ${id.toString().substring(0, 8)}…'
            : 'Report submitted successfully!';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 6),
          ),
        );
      }
    } catch (e) {
      if (context.mounted && !dialogDismissed) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 6),
          ),
        );
      }
    }
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getDomainLabel2400(int value) {
    switch (value) {
      case 0:
        return 'ISM';
      case 1:
        return 'EU CE LBT';
      default:
        return 'Unknown';
    }
  }

  String _getDomainLabel900(int value) {
    switch (value) {
      case 0:
        return 'AU915';
      case 1:
        return 'FCC915';
      case 2:
        return 'EU868';
      case 3:
        return 'IN866';
      case 4:
        return 'AU433';
      case 5:
        return 'EU433';
      case 6:
        return 'US433';
      default:
        return 'Unknown';
    }
  }


  Widget _buildEditDialogTile(
    BuildContext context, {
    required String title,
    required String currentValue,
    required Function(String) onSaved,
    bool isSecret = false,
    ValueNotifier<bool>? isVisibleNotifier,
  }) {
    final l10n = AppLocalizations.of(context)!;
    Widget buildTile(bool isVisible) {
      final subtitle = currentValue.isEmpty
          ? l10n.notSetLabel
          : (isSecret && !isVisible ? '••••••••' : currentValue);

      return ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSecret && isVisibleNotifier != null)
              IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  size: 20,
                ),
                onPressed: () =>
                    isVisibleNotifier.value = !isVisibleNotifier.value,
              ),
            const Icon(Icons.edit, size: 20),
          ],
        ),
        onTap: () {
          final textController = TextEditingController(text: currentValue);
          bool obscureText = isSecret && !isVisible;

          showDialog(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text('Edit $title'),
                ),
                scrollable: true,
                content: TextField(
                  controller: textController,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    hintText: 'Enter $title',
                    hintMaxLines: 2,
                    suffixIcon: isSecret
                        ? IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          )
                        : null,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.cancelLabel),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onSaved(textController.text);
                      Navigator.pop(context);
                    },
                    child: Text(l10n.saveLabel),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    if (isSecret && isVisibleNotifier != null) {
      return ValueListenableBuilder<bool>(
        valueListenable: isVisibleNotifier,
        builder: (context, isVisible, child) => buildTile(isVisible),
      );
    }

    return buildTile(false);
  }

  String _getLocaleName(String code) {
    switch (code) {
      case 'en': return 'English';
      case 'de': return 'Deutsch';
      case 'es': return 'Español';
      case 'fr': return 'Français';
      case 'ja': return '日本語';
      case 'uk': return 'Українська';
      case 'pt': return 'Português';
      case 'it': return 'Italiano';
      case 'pl': return 'Polski';
      case 'ko': return '한국어';
      default: return code;
    }
  }
}

