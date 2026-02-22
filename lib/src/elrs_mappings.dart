import 'package:binary/binary.dart';

/// Categories representing the physical hardware frequency bands.
enum FrequencyCategory {
  freq900MHz,
  freq2400MHz,
}

/// Regulatory domains for 900MHz hardware.
const List<String> domains900 = ['FCC', 'EU', 'AU'];

/// Regulatory domains for 2.4GHz hardware.
const List<String> domains2400 = ['ISM', 'EU_LBT'];

/// Returns the string label for a regulatory domain index.
/// 
/// Uses explicit bounds checking for high-performance UI updates.
String getDomainLabel(int index, FrequencyCategory category) {
  final list = category == FrequencyCategory.freq900MHz ? domains900 : domains2400;
  
  if (index >= 0 && index < list.length) {
    return list[index];
  }
  
  return 'Unknown';
}
