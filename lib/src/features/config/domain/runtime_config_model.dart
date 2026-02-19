import 'package:freezed_annotation/freezed_annotation.dart';

part 'runtime_config_model.freezed.dart';
part 'runtime_config_model.g.dart';

@freezed
abstract class RuntimeConfig with _$RuntimeConfig {
  const factory RuntimeConfig({
    @JsonKey(name: 'product_name') String? productName,
    @Default('unknown') String version,
    String? target,
    String? activeIp,
    @Default({}) Map<String, dynamic> settings,
    @Default({}) Map<String, dynamic> options,
    @Default({}) Map<String, dynamic> config,
  }) = _RuntimeConfig;

  factory RuntimeConfig.fromJson(Map<String, dynamic> json) =>
      _$RuntimeConfigFromJson(json);
}
