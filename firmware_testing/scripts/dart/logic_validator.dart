import 'dart:io';
import 'dart:typed_data';
import 'package:binary/binary.dart';
import 'package:path/path.dart' as p;

/// Logic Validator
///
/// Role: Internal Logic Verification (Lead Developer)
/// Purpose: Verifying segment mirrors and internal assembly logic consistent with package:binary.
///
/// Architectural Requirements:
/// 1. Interactive CLI Loop
/// 2. Memory Management (viewOrCopyAsBytes)
/// 3. Type Safety & Performance (Uint8, Uint32, fromUnchecked)
/// 4. Assembly Logic Mirroring (BytesBuilderExtension)
/// 5. Bit-Level Analysis Loop (nthBit, slice, chunk)
/// 6. Reporting (Timestamped logs)

void main() async {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final projectRoot = scriptDir.parent.parent.parent;
  final binariesDir = Directory(
    p.join(projectRoot.path, 'firmware_testing', 'binaries'),
  );

  if (!await binariesDir.exists()) {
    stdout.writeln('Error: binaries directory not found at ${binariesDir.path}');
    return;
  }

  while (true) {
    final searchDirs = [Directory.current, binariesDir];
    final List<File> files = [];

    for (final dir in searchDirs) {
      if (await dir.exists()) {
        await for (final entity in dir.list()) {
          if (entity is File &&
              (entity.path.endsWith('.bin') || entity.path.endsWith('.gz'))) {
            files.add(entity);
          }
        }
      }
    }

    if (files.isEmpty) {
      stdout.writeln('No .bin or .gz files found.');
      return;
    }

    // Deduplicate and sort
    final uniqueFiles = {for (var f in files) f.path: f}.values.toList()
      ..sort((a, b) => a.path.compareTo(b.path));

    stdout.writeln('\nAvailable Firmware Binaries:');
    for (var i = 0; i < uniqueFiles.length; i++) {
      stdout.writeln('[$i] ${p.relative(uniqueFiles[i].path)}');
    }
    stdout.writeln('[q] Quit');

    stdout.write('\nSelect first file index: ');
    final input1 = stdin.readLineSync();
    if (input1 == 'q') break;

    stdout.write('Select second file index: ');
    final input2 = stdin.readLineSync();
    if (input2 == 'q') break;

    final idx1 = int.tryParse(input1 ?? '');
    final idx2 = int.tryParse(input2 ?? '');

    if (idx1 == null ||
        idx2 == null ||
        idx1 < 0 ||
        idx1 >= uniqueFiles.length ||
        idx2 < 0 ||
        idx2 >= uniqueFiles.length) {
      stdout.writeln('Invalid selection. Please try again.');
      continue;
    }

    await validateBinaries(uniqueFiles[idx1], uniqueFiles[idx2], projectRoot);
  }
}

Future<Uint8List> loadFirmwareData(File file) async {
  final bytes = await file.readAsBytes();
  if (file.path.endsWith('.gz')) {
    return Uint8List.fromList(gzip.decode(bytes));
  }
  return bytes;
}

Future<void> validateBinaries(
    File file1, File file2, Directory projectRoot) async {
  stdout.writeln('\nLoading ${p.basename(file1.path)}...');
  final buffer1 = await loadFirmwareData(file1);
  stdout.writeln('Loading ${p.basename(file2.path)}...');
  final buffer2 = await loadFirmwareData(file2);

  final logDir =
      Directory(p.join(projectRoot.path, 'firmware_testing', 'logs'));
  if (!await logDir.exists()) {
    await logDir.create(recursive: true);
  }

  final logFile = File(
    p.join(logDir.path, 'diff_${DateTime.now().millisecondsSinceEpoch}.log'),
  );

  final logSink = logFile.openWrite();
  logSink.writeln('Comparison Report: ${DateTime.now()}');
  logSink.writeln('File 1: ${file1.path}');
  logSink.writeln('File 2: ${file2.path}\n');

  int discrepancies = 0;
  final minLength =
      buffer1.length < buffer2.length ? buffer1.length : buffer2.length;

  if (buffer1.length != buffer2.length) {
    logSink.writeln(
      'WARNING: File sizes differ! ${buffer1.length} vs ${buffer2.length}',
    );
  }

  // Requirement 5: Bit-Level Analysis Loop
  for (int i = 0; i < minLength; i++) {
    final b1 = !debugCheckUncheckedInRange
        ? Uint8.fromUnchecked(buffer1[i])
        : Uint8(buffer1[i]);

    final b2 = !debugCheckUncheckedInRange
        ? Uint8.fromUnchecked(buffer2[i])
        : Uint8(buffer2[i]);

    if (b1 != b2) {
      discrepancies++;
      logSink.writeln(
        'Mismatch at offset 0x${i.toRadixString(16).padLeft(8, '0')}:',
      );
      logSink.writeln(
        '  File 1: 0x${b1.toInt().toRadixString(16).padLeft(2, '0')} (${b1.toBinaryString()})',
      );
      logSink.writeln(
        '  File 2: 0x${b2.toInt().toRadixString(16).padLeft(2, '0')} (${b2.toBinaryString()})',
      );

      // Pinpoint exact bit failure
      for (int bit = 0; bit < 8; bit++) {
        if (b1.nthBit(bit) != b2.nthBit(bit)) {
          logSink.writeln('    -> Bit $bit differs');
        }
      }
    }
  }

  await logSink.close();
  stdout.writeln('Validation complete. Found $discrepancies discrepancies.');
  stdout.writeln('Log written to: ${logFile.path}');
}

/// Requirement 4: Assembly Logic Mirroring
extension BytesBuilderExtension on BytesBuilder {
  void addWord(int value, Endian endian) {
    final bytes = Uint8List(2);
    ByteData.view(bytes.buffer).setUint16(0, value, endian);
    add(bytes);
  }

  void addDWord(int value, Endian endian) {
    final bytes = Uint8List(4);
    ByteData.view(bytes.buffer).setUint32(0, value, endian);
    add(bytes);
  }

  void addWords(Iterable<int> values, Endian endian) {
    for (final value in values) {
      addWord(value, endian);
    }
  }
}
