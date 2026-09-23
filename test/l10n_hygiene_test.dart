// Guards against localisation regressions:
//  1. user-facing text hardcoded in UI code instead of coming from ARB, and
//  2. ARB keys that no code uses (they still cost a translation per locale).
//
// Text that is intentionally the same in every language (the app name, for
// example) is exempted with a `// l10n-ignore` comment on the literal's line
// or the line above it.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Widget constructors and named arguments whose string is shown to users.
final _uiTextSlot = RegExp(
  r'''(?:\b(?:Text|SelectableText)\(\s*|\b(?:labelText|hintText|helperText|errorText|tooltip|title|subtitle|content|message|label|semanticLabel|semanticsLabel|dialogTitle)\s*:\s*)(?:const\s+)?(?:(?:Selectable)?Text\(\s*)?(['"])((?:\\.|(?!\1).)*)\1''',
);

/// Interpolations don't count as text: `'$version'` alone is fine.
final _interpolation = RegExp(r'\$\{[^}]*\}|\$\w+');
final _words = RegExp(r'[A-Za-z]{2,}');

const _ignoreMarker = 'l10n-ignore';

Iterable<File> _dartFiles(String dir) => Directory(dir)
    .listSync(recursive: true)
    .whereType<File>()
    .where((f) => f.path.endsWith('.dart'))
    .where((f) => !f.path.endsWith('.g.dart') && !f.path.endsWith('.freezed.dart'))
    .where((f) => !f.path.contains('/localization/'));

void main() {
  test('UI code has no hardcoded user-facing text', () {
    final uiFiles = [
      ..._dartFiles('lib/src').where((f) => f.path.contains('/presentation/')),
      File('lib/src/app.dart'),
    ];

    final offenders = <String>[];
    for (final file in uiFiles) {
      final source = file.readAsStringSync();
      final lines = source.split('\n');
      for (final match in _uiTextSlot.allMatches(source)) {
        final text = match.group(2)!.replaceAll(_interpolation, '');
        if (!_words.hasMatch(text) || text.startsWith('http')) continue;

        // Line of the literal itself, which may follow `Text(` on a new line.
        final literalOffset = match.start + match.group(0)!.indexOf(match.group(1)!);
        final line = '\n'.allMatches(source.substring(0, literalOffset)).length;
        final exempt = lines[line].contains(_ignoreMarker) ||
            (line > 0 && lines[line - 1].contains(_ignoreMarker));
        if (!exempt) {
          offenders.add('${file.path}:${line + 1}: ${match.group(2)}');
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason: 'Move these strings to lib/l10n/app_en.arb, or mark text that '
          'is deliberately the same in every language with '
          '// $_ignoreMarker',
    );
  });

  test('every ARB key is used by the app', () {
    final template =
        jsonDecode(File('lib/l10n/app_en.arb').readAsStringSync())
            as Map<String, dynamic>;
    final keys = template.keys.where((k) => !k.startsWith('@'));

    final source = _dartFiles('lib').map((f) => f.readAsStringSync()).join('\n');
    final unused = keys
        .where((key) => !RegExp('\\.$key\\b').hasMatch(source))
        .toList();

    expect(
      unused,
      isEmpty,
      reason: 'Unused keys are still translated into every locale. Delete '
          'them from app_en.arb; scripts/arb_stale_check.js prunes the '
          'locales on the next translation run.',
    );
  });
}
