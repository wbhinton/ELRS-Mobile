import 'package:elrs_mobile/src/core/storage/persistence_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late _MockSecureStorage secure;
  late PersistenceService persistence;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    secure = _MockSecureStorage();
    persistence = PersistenceService(
      await SharedPreferences.getInstance(),
      secure,
    );
  });

  void stubStatus(SecureStorageUpgradeState state) {
    when(() => secure.checkUpgradeStatus()).thenAnswer(
      (_) async => SecureStorageUpgradeStatus(
        state: state,
        reason: SecureStorageUpgradeReason.missingAlgorithmMarkers,
        entryCount: 4,
        willDiscardOnNextAccess: true,
      ),
    );
  }

  test('flags data a direct v9 -> v11 upgrade cannot read', () async {
    stubStatus(SecureStorageUpgradeState.legacyDataUnreadable);
    await persistence.checkSecureStorageUpgrade();
    expect(persistence.secureDataLostOnUpgrade, isTrue);

    await persistence.clearSecureDataLostNotice();
    expect(persistence.secureDataLostOnUpgrade, isFalse);
  });

  test('flags data an earlier access already discarded', () async {
    stubStatus(SecureStorageUpgradeState.legacyDataDiscarded);
    await persistence.checkSecureStorageUpgrade();
    expect(persistence.secureDataLostOnUpgrade, isTrue);
  });

  test('migrated or empty storage is not flagged', () async {
    stubStatus(SecureStorageUpgradeState.ok);
    await persistence.checkSecureStorageUpgrade();
    expect(persistence.secureDataLostOnUpgrade, isFalse);
  });

  test('a failing check never blocks startup', () async {
    when(() => secure.checkUpgradeStatus()).thenThrow(Exception('keystore'));
    await persistence.checkSecureStorageUpgrade();
    expect(persistence.secureDataLostOnUpgrade, isFalse);
  });
}
