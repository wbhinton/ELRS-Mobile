import 'dart:collection';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:github_snitch/github_snitch.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BugReportService {
  static final BugReportService instance = BugReportService._internal();
  BugReportService._internal();

  final _logBuffer = Queue<String>();
  static const int _maxLogLines = 200;

  // Whether GhSnitch was initialized with a valid token at startup.
  // False if the app was launched without --dart-define-from-file.
  bool _configured = false;
  bool get isConfigured => _configured;

  void init() {
    // 1. Initialize GitHub Snitch with PAT from environment
    const String githubToken = String.fromEnvironment('GITHUB_TOKEN');
    if (githubToken.isNotEmpty) {
      GhSnitch.initialize(
        token: githubToken,
        owner: 'wbhinton',
        repo: 'ELRS-Mobile',
      );
      GhSnitch.listenToExceptions(labels: ['crash', 'auto-report']);
      _configured = true;
    } else {
      Logger.root.warning(
        'BugReportService: GITHUB_TOKEN not set. '
        'Launch with --dart-define-from-file=dart_defines/local.json',
      );
    }

    // 2. Set up logging listener
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      final logLine = '${record.time}: ${record.level.name}: ${record.loggerName}: ${record.message}';
      _logBuffer.addLast(logLine);
      if (_logBuffer.length > _maxLogLines) {
        _logBuffer.removeFirst();
      }
    });
  }

  /// Submits a bug report. Returns null on success, or an error string on failure.
  Future<String?> submitReport(String title, String description) async {
    if (!_configured) {
      return 'Bug reporting is not configured. '
          'Reinstall the app from a release build.';
    }
    try {
      final metadata = await _collectMetadata();
      final logs = _logBuffer.toList().reversed.join('\n');

      final body = '''
### Description
$description

### System Metadata
$metadata

### Recent Logs (Last $_maxLogLines lines)
```
$logs
```
''';

      final ok = await GhSnitch.report(
        title: title,
        body: body,
        labels: ['bug', 'user-report'],
      ).timeout(
        const Duration(seconds: 12),
        onTimeout: () => false,
      );
      return ok ? null : 'GitHub rejected the report (check token permissions or internet connection).';
    } catch (e) {
      Logger.root.severe('Failed to submit bug report: $e');
      return e.toString();
    }
  }

  Future<String> _collectMetadata() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String systemInfo = '';

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      systemInfo = 'Model: ${androidInfo.model}, Brand: ${androidInfo.brand}, Android Version: ${androidInfo.version.release}, SDK: ${androidInfo.version.sdkInt}';
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      systemInfo = 'Model: ${iosInfo.utsname.machine}, System Name: ${iosInfo.systemName}, System Version: ${iosInfo.systemVersion}';
    } else {
      systemInfo = 'Platform: ${Platform.operatingSystem}, Version: ${Platform.operatingSystemVersion}';
    }

    return '''
App Version: ${packageInfo.version} (${packageInfo.buildNumber})
$systemInfo
''';
  }
}
