import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'connection_repository.dart';

part 'device_dio.g.dart';

@riverpod
Dio deviceDio(Ref ref) {
  // Watch centralized target IP provider
  final ip = ref.watch(targetIpProvider);
  final baseUrl = ip != null ? 'http://$ip' : '';

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'User-Agent': 'ELRSManager/1.0',
      },
      // Ensure we don't follow redirects automatically if that causes issues with captive portals,
      // though typically ELRS devices don't redirect.
    ),
  );
  return dio;
}
