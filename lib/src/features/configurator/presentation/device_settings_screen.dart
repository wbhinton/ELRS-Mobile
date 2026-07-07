import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:elrs_mobile/src/localization/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_selector/file_selector.dart';
import '../../config/presentation/config_view_model.dart';
import 'package:go_router/go_router.dart';
import '../../../core/analytics/analytics_service.dart';

class DeviceSettingsScreen extends ConsumerStatefulWidget {
  const DeviceSettingsScreen({super.key});

  @override
  ConsumerState<DeviceSettingsScreen> createState() =>
      _DeviceSettingsScreenState();
}

class _DeviceSettingsScreenState extends ConsumerState<DeviceSettingsScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  int? _androidSdkVersion;

  @override
  void initState() {
    super.initState();
    _initWebView();
    _initAndroidVersion();
  }

  void _initWebView() {
    final ip = ref.read(configViewModelProvider.notifier).probeIp ?? '10.0.0.1';

    // Track Webview Usage
    ref.read(analyticsServiceProvider).trackEvent('Config Webview Opened', {
      'connection_type': ip == '10.0.0.1' ? 'Access Point' : 'Home WiFi',
    });

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(
        const Color(0xFF121212),
      ) // ELRS dark theme background match
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            // Only allow navigation to themes/pages on the local device IP
            final uri = Uri.parse(request.url);
            if (uri.host == ip) {
              return NavigationDecision.navigate;
            }
            debugPrint(
              'Blocked external navigation in Config WebView: ${request.url}',
            );
            return NavigationDecision.prevent;
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('http://$ip/'));

    // Provide a bridge for the HTML <input type="file"> on Android
    if (_controller.platform is AndroidWebViewController) {
      (_controller.platform as AndroidWebViewController).setOnShowFileSelector(
        (FileSelectorParams params) async {
          const typeGroup = XTypeGroup(
            label: 'Firmware Binaries',
            extensions: ['bin', 'gz'],
          );
          final file = await openFile(acceptedTypeGroups: [typeGroup]);
          
          if (file != null) {
            return [file.path];
          }
          return [];
        },
      );
    }
  }

  Future<void> _initAndroidVersion() async {
    if (!kIsWeb && Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (mounted) {
        setState(() {
          _androidSdkVersion = androidInfo.version.sdkInt;
        });
      }
    }
  }

  Widget _buildWebView() {
    if (!kIsWeb && Platform.isAndroid) {
      if (_androidSdkVersion == null) {
        // Still loading Android version info, so we wait before attaching the WebView.
        return const SizedBox.shrink();
      }
      if (_androidSdkVersion! < 29) { // Android 10 is API 29
        return WebViewWidget.fromPlatformCreationParams(
          params: AndroidWebViewWidgetCreationParams(
            controller: _controller.platform,
            displayWithHybridComposition: false, // Fallback for older Android (MediaTek protection)
          ),
        );
      }
    }
    return WebViewWidget(controller: _controller);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.deviceConfigLabel),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _buildWebView(),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: Color(0xFF00E5FF)),
              ),
          ],
        ),
      ),
    );
  }
}
