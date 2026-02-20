import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/storage/firmware_cache_service.dart';

part 'releases_repository.g.dart';

class ReleasesRepository {
  final Dio _dio;

  ReleasesRepository(this._dio);

  Future<List<String>> fetchVersions() async {
    try {
      // Use Artifactory Index to ensure we only list versions we can actually download.
      // Index URL: https://artifactory.expresslrs.org/ExpressLRS/index.json
      final response = await _dio.get('https://artifactory.expresslrs.org/ExpressLRS/index.json');
      
      // key = version string, value = hash
      final Map<String, dynamic> tags = response.data['tags'];
      
      // Filter for versions >= 3.0.0 (including 4.x)
      // Sort descending (newest first)
      final versions = tags.keys.where((tag) {
        final clean = tag.startsWith('v') ? tag.substring(1) : tag;
        // Basic check: starts with digit and >= 3
        if (clean.isEmpty) return false;
        final major = int.tryParse(clean.split('.')[0]);
        return major != null && major >= 3;
      }).toList();
      
      // Sort using SemVer-ish logic
      versions.sort((a, b) {
         return _compareVersions(b, a); // Descending
      });
      
      return versions;
    } catch (e) {
       print('RELEASES: Offline or Artifactory unreachable. Fallback to cache may be available.');
       rethrow; // Provider will handle the error and fallback to cache
    }
  }

  int _compareVersions(String v1, String v2) {
    // quick semver compare
    final p1 = v1.startsWith('v') ? v1.substring(1) : v1;
    final p2 = v2.startsWith('v') ? v2.substring(1) : v2;
    
    final parts1 = p1.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final parts2 = p2.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    
    for (var i = 0; i < 3; i++) {
      final n1 = i < parts1.length ? parts1[i] : 0;
      final n2 = i < parts2.length ? parts2[i] : 0;
      if (n1 != n2) return n1.compareTo(n2);
    }
    return 0;
  }
}

@riverpod
ReleasesRepository releasesRepository(Ref ref) {
  return ReleasesRepository(Dio());
}

@riverpod
Future<List<String>> releases(Ref ref) async {
  final repo = ref.watch(releasesRepositoryProvider);
  try {
    return await repo.fetchVersions();
  } catch (e) {
    print('Failed to fetch releases ($e). Checking cache...');
    final cacheService = ref.read(firmwareCacheServiceProvider);
    final cached = await cacheService.getCachedVersions();
    
    if (cached.isEmpty) {
      throw Exception('No versions available (Offline & Cache Empty). Details: $e');
    }
    return cached;
  }
}
