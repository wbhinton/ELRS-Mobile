
import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:elrs_mobile/src/features/flashing/utils/target_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TargetResolver', () {
    test('applyOverlay merges correctly', () {
      final base = {'a': 1, 'b': 2};
      final overlay = {'b': 3, 'c': 4};
      final result = TargetResolver.applyOverlay(base, overlay);
      expect(result, equals({'a': 1, 'b': 3, 'c': 4}));
    });

    test('resolveLayout finds file in RX folder', () {
      final archive = Archive();
      final layoutContent = jsonEncode({'serial_rx': 1});
      final file = ArchiveFile('RX/layout.json', layoutContent.length, layoutContent.codeUnits);
      archive.addFile(file);

      final targetConfig = {
        'layout_file': 'layout.json',
        'firmware': 'ESP32_2400_RX',
        'overlay': {'serial_tx': 2}
      };

      final result = TargetResolver.resolveLayout(targetConfig, archive);
      expect(result['serial_rx'], equals(1));
    });

    test('resolveLayout falls back to basename search', () {
      final archive = Archive();
      final layoutContent = jsonEncode({'val': 1});
      // File is deep in some other folder
      final file = ArchiveFile('some/weird/path/layout.json', layoutContent.length, layoutContent.codeUnits);
      archive.addFile(file);

      final targetConfig = {
        'layout_file': 'layout.json', 
        'firmware': 'UNKNOWN',
      };

      final result = TargetResolver.resolveLayout(targetConfig, archive);
      expect(result['val'], equals(1));
    });

    test('resolveLayout throws specific error when not found', () {
      final archive = Archive();
      final targetConfig = {'layout_file': 'missing.json'};
      
      try {
        TargetResolver.resolveLayout(targetConfig, archive);
        fail('Should have thrown');
      } catch (e) {
        expect(e.toString(), contains('Could not find layout "missing.json"'));
      }
    });
  });
}
