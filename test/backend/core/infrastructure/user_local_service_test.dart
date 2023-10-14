// Package imports:
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/user_dto.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_local_service.dart';
import 'package:joyful_noise/core/infrastructure/sembast_database.dart';

class FakeSembastDatabase extends Fake implements SembastDatabase {
  FakeSembastDatabase(this._database);
  final Database _database;

  @override
  Database get instance => _database;
}

void main() {
  group('UserLocalService', () {
    group('.saveUser', () {
      test('stores the User object in the database', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final userLocalService = UserLocalService(fakeSembastDatabase);

        final userJson = {'id': 0, 'email': 'hey@hey.com'};

        final userDTO = UserDTO.fromJson(userJson);

        await userLocalService.saveUser(userDTO);

        final actualData = await UserLocalService.store.record(UserLocalService.key).get(fakeSembastDatabase.instance);

        final expectedData = userJson;

        expect(actualData, expectedData);
      });
    });

    group('.getUser', () {
      test('gets the User object in the database', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final userLocalService = UserLocalService(fakeSembastDatabase);

        final userJson = {'id': 0, 'email': 'hey@hey.com'};

        final userDTO = UserDTO.fromJson(userJson);

        await UserLocalService.store.record(UserLocalService.key).put(fakeSembastDatabase.instance, userJson);

        final actualData = await userLocalService.getUser();

        final expectedData = userDTO;

        expect(actualData, expectedData);
      });
    });

    group('.deleteUser', () {
      test('deletes the User object from the database', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final userLocalService = UserLocalService(fakeSembastDatabase);

        final userJson = {'id': 0, 'email': 'hey@hey.com'};

        await UserLocalService.store.record(UserLocalService.key).put(fakeSembastDatabase.instance, userJson);

        await userLocalService.deleteUser();

        final actualData = await UserLocalService.store.record(UserLocalService.key).get(fakeSembastDatabase.instance);

        // ignore: prefer_void_to_null
        const Null expectedData = null;

        expect(actualData, expectedData);
      });
    });
  });
}
