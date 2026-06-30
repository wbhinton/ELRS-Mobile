import 'package:freezed_annotation/freezed_annotation.dart';

part 'flashing_profile.freezed.dart';
part 'flashing_profile.g.dart';

@freezed
abstract class FlashingProfile with _$FlashingProfile {
  const factory FlashingProfile({
    required String id,
    required String name,
    @Default('') String bindPhrase,
    @Default('') String wifiSsid,
    @Default('') String wifiPassword,
    @Default(0) int defaultDomain2400,
    @Default(1) int defaultDomain900,
  }) = _FlashingProfile;

  factory FlashingProfile.fromJson(Map<String, dynamic> json) => _$FlashingProfileFromJson(json);
}
