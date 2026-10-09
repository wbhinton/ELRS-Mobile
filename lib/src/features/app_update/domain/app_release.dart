/// The latest direct-download release, as published to
/// https://cdn.elrsmobile.com/latest.json by the release workflow.
class AppRelease {
  const AppRelease({
    required this.version,
    required this.versionCode,
    required this.downloadUrl,
  });

  /// Human-readable version name, e.g. `1.0.45`.
  final String version;

  /// Android versionCode; this is what update checks compare.
  final int versionCode;

  /// Link to this exact release's APK. The versioned `url` is preferred over
  /// `latest_url`: the two files are edge-cached separately, so right after
  /// a release the stable link can still serve the previous APK.
  final Uri downloadUrl;

  /// Returns null when [json] is missing a field or malformed, so a bad
  /// manifest never prompts an update.
  static AppRelease? tryParse(Object? json) {
    if (json is! Map<String, dynamic>) return null;
    final version = json['version'];
    final versionCode = json['version_code'];
    final url = json['url'] ?? json['latest_url'];
    if (version is! String || versionCode is! int || url is! String) {
      return null;
    }
    final uri = Uri.tryParse(url);
    if (uri == null || uri.scheme != 'https') return null;
    return AppRelease(
      version: version,
      versionCode: versionCode,
      downloadUrl: uri,
    );
  }
}
