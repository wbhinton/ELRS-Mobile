import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
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

  @override
  void initState() {
    super.initState();

    // Fallback to default ELRS IP if not found
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
  }

  Widget _buildWebView() {
    if (Platform.isAndroid) {
      return WebViewWidget.fromPlatformCreationParams(
        params: AndroidWebViewWidgetCreationParams(
          controller: _controller.platform,
          displayWithHybridComposition: false, // Fallback to TextureView to avoid MediaTek driver crashes
        ),
      );
    }
    return WebViewWidget(controller: _controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Configuration'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          _buildWebView(),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: Color(0xFF00E5FF)),
            ),
        ],
      ),
    );
  }
}
