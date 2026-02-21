class ElrsMappings {
  // Regulatory Domains
  static const Map<int, String> domains = {
    0: 'AU915',
    1: 'FCC915',
    2: 'EU868',
    3: 'IN866',
    4: 'AU433',
    5: 'EU433',
    6: 'US433',
    7: 'US433-Wide',
  };

  // VBind (Binding Storage)
  static const Map<int, String> vbind = {
    0: 'Persistent',
    1: 'Volatile',
    2: 'Returnable',
    3: 'Administered',
  };

  // Serial Protocols (Main)
  static const Map<int, String> serialProtocols = {
    0: 'CRSF',
    1: 'SBUS',
    2: 'SUMD',
    3: 'DJI RS Pro',
    4: 'MAVLink',
    5: 'AirPort',
    6: 'HoTT Telemetry',
    7: 'Jetibox',
    8: 'M-Link',
    9: 'G-Link',
    10: 'Serial VTX',
  };

  // Serial 1 Protocols (Same as Main + Off/Tramp)
  static final Map<int, String> serial1Protocols = {
    ...serialProtocols,
    11: 'Off',
    12: 'IRC Tramp',
  };

  // SBUS Failsafe Options
  static const Map<int, String> sbusFailsafe = {
    1: 'No Pulses',
    2: 'Last Position',
  };

  // PWM Modes (Timers and Serial)
  static const Map<int, String> pwmModes = {
    0: '50Hz',
    1: '60Hz',
    2: '100Hz',
    3: '160Hz',
    4: '333Hz',
    5: '400Hz',
    6: 'On/Off',
    7: 'DSHOT300',
    8: 'Serial TX',
    9: 'Serial RX',
  };

  // Helper method to look up a value safely
  static String getMapping(Map<int, String> map, int key, {String fallback = 'Unknown'}) {
    return map[key] ?? fallback;
  }
}
