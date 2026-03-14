import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../domain/update_state.dart';
import 'package:aptabase_flutter/aptabase_flutter.dart';

part 'update_controller.g.dart';

@Riverpod(keepAlive: true)
class UpdateController extends _$UpdateController {
  @override
  UpdateState build() {
    return const UpdateState();
  }

  Future<void> checkForUpdates() async {
    if (state.isChecking) return;

    state = state.copyWith(isChecking: true);

    try {
      final dio = Dio();
      // Use the raw Gist URL for checking updates
      final response = await dio.get(
        'https://gist.githubusercontent.com/wbhinton/c9b5a121255eee1d9673198db1b9b3c8/raw/version.json',
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final latestVersion = data['version'] as String;
        final releaseUrl = data['url'] as String;

        final packageInfo = await PackageInfo.fromPlatform();
        final currentVersion = packageInfo.version;

        if (_isNewer(latestVersion, currentVersion)) {
          Aptabase.instance.trackEvent('Update Checked', {
            'result': 'Update Available',
            'latest': latestVersion,
            'current': currentVersion,
          });
          state = state.copyWith(
            isUpdateAvailable: true,
            latestVersion: latestVersion,
            releaseUrl: releaseUrl,
            isChecking: false,
          );
        } else {
          Aptabase.instance.trackEvent('Update Checked', {
            'result': 'Up To Date',
            'current': currentVersion,
          });
          state = state.copyWith(isChecking: false);
        }
      }
    } catch (e) {
      Aptabase.instance.trackEvent('Update Check Failed', {
        'error': e.toString(),
      });
      // Silently fail update check to avoid annoying user if offline
      state = state.copyWith(isChecking: false);
    }
  }

  void dismissUpdate() {
    state = state.copyWith(dismissed: true);
  }

  bool _isNewer(String latest, String current) {
    // Simple semver-ish comparison
    final vLatest = latest.split('.').map(int.tryParse).toList();
    final vCurrent = current.split('.').map(int.tryParse).toList();

    for (var i = 0; i < 3; i++) {
      final l = vLatest.elementAtOrNull(i) ?? 0;
      final c = vCurrent.elementAtOrNull(i) ?? 0;
      if (l > c) return true;
      if (l < c) return false;
    }
    return false;
  }
}
