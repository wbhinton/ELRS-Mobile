import 'package:flutter/services.dart' show rootBundle;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class LuaExportUtils {
  static Future<void> exportElrsLuaScript() async {
    // Load the script directly from the app's bundled assets
    final byteData = await rootBundle.load('assets/lua/elrs.lua');
    final bytes = byteData.buffer.asUint8List();

    // Trigger the native iOS/Android 'Save As' dialog
    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Save ELRS Lua Script',
      fileName: 'elrs.lua',
      bytes: bytes,
    );

    if (result != null) {
      debugPrint('ELRS Lua script saved successfully to $result');
    }
  }
}
