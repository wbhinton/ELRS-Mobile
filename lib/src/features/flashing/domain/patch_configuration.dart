import 'package:freezed_annotation/freezed_annotation.dart';

part 'patch_configuration.freezed.dart';

@freezed
abstract class PatchConfiguration with _$PatchConfiguration {
  const factory PatchConfiguration({
    required String bindPhrase,
    String? wifiSsid,
    String? wifiPassword,
    int? regulatoryDomain,
    int? domain,
    int? wifiOnInterval,
    List<int>? uid,
  }) = _PatchConfiguration;
}
