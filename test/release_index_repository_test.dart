import 'dart:convert';
import 'dart:io';

import 'package:elrs_mobile/src/features/flashing/data/release_index_repository.dart';
import 'package:elrs_mobile/src/features/flashing/data/releases_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class _MemoryStore implements ReleaseIndexStore {
  String? value;
  int saves = 0;

  @override
  Future<String?> load() async => value;

  @override
  Future<void> save(String json) async {
    value = json;
    saves++;
  }
}

String _index(Map<String, String> tags) => jsonEncode({'tags': tags});

Map<String, String> _tags(int n) =>
    {for (var i = 0; i < n; i++) '3.$i.0': 'hash$i'};

/// Shape of the index served on 2026-11-27: one branch, no tags.
const _brokenUpstream = '''
{"branches": {"feature-branch": "0000000000000000000000000000000000000000"},
 "tags": {}}
''';

void main() {
  late _MemoryStore store;

  ReleaseIndexRepository repo(Object? live, {String? bundled}) =>
      ReleaseIndexRepository(
        fetchLive: () async => live,
        store: store,
        loadBundled: () async => bundled ?? _index({}),
      );

  setUp(() => store = _MemoryStore());

  test('healthy live index is returned and saved as last good', () async {
    final tags = await repo(jsonDecode(_index(_tags(10)))).fetchTags();

    expect(tags, _tags(10));
    expect(ReleaseIndexRepository.parseTags(store.value), _tags(10));
  });

  test('empty live index falls back to saved last good, without saving',
      () async {
    store.value = _index(_tags(10));

    final tags = await repo(_brokenUpstream).fetchTags();

    expect(tags, _tags(10));
    expect(store.saves, 0);
  });

  test('empty live index with nothing saved falls back to bundled', () async {
    final tags =
        await repo(_brokenUpstream, bundled: _index(_tags(5))).fetchTags();

    expect(tags, _tags(5));
  });

  test('index that lost more than half its tags is degraded; live tags merged',
      () async {
    store.value = _index(_tags(10));
    final live = {'3.0.0': 'hash0', '4.2.0': 'newhash'};

    final tags = await repo(_index(live)).fetchTags();

    expect(tags.length, 11);
    expect(tags['4.2.0'], 'newhash');
    expect(store.saves, 0);
  });

  test('healthy index honours upstream removal of a tag', () async {
    store.value = _index(_tags(10));
    final live = _tags(10)..remove('3.9.0');

    final tags = await repo(_index(live)).fetchTags();

    expect(tags.containsKey('3.9.0'), isFalse);
    expect(store.saves, 1);
  });

  test('malformed payloads are treated as degraded', () async {
    store.value = _index(_tags(4));
    for (final bad in ['not json', '{"tags": []}', null, 42]) {
      expect(await repo(bad).fetchTags(), _tags(4), reason: '$bad');
    }
  });

  test('network failure is rethrown so offline handling still applies',
      () async {
    store.value = _index(_tags(4));
    final r = ReleaseIndexRepository(
      fetchLive: () async => throw const SocketException('offline'),
      store: store,
    );

    expect(r.fetchTags(), throwsA(isA<SocketException>()));
  });

  test('version list survives the 2026-11-27 outage via bundled asset',
      () async {
    final bundled = File('assets/expresslrs_index.json').readAsStringSync();
    final releases =
        ReleasesRepository(repo(_brokenUpstream, bundled: bundled));

    final versions = await releases.fetchVersions();

    expect(versions, isNotEmpty);
    expect(versions, contains('3.3.0'));
    expect(versions, isNot(contains('3.2.1')));
  });
}
