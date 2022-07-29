// Package imports:
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/core/infrastructure/sembast_database.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';

class FakeSembastDatabase extends Fake implements SembastDatabase {
  FakeSembastDatabase(this._database);
  final Database _database;

  @override
  Database get instance => _database;
}

void main() {
  group('SearchHistoryRepository', () {
    group('.addSearchTerm', () {
      test('stores the search term in the database', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final searchHistoryRepository = SearchHistoryRepository(fakeSembastDatabase);

        const searchTerm = 'query';
        const searchTerm2 = 'test';

        await searchHistoryRepository.addSearchTerm(searchTerm);
        await searchHistoryRepository.addSearchTerm(searchTerm2);

        final actualData = await SearchHistoryRepository.store.record(2).get(fakeSembastDatabase.instance);
        const expectedData = searchTerm2;

        expect(actualData, expectedData);
      });
      test('does not duplicate search term in the database', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final searchHistoryRepository = SearchHistoryRepository(fakeSembastDatabase);

        const searchTerm = 'query';
        const searchTerm2 = 'test';
        const searchTerm3 = 'query';

        await searchHistoryRepository.addSearchTerm(searchTerm);
        await searchHistoryRepository.addSearchTerm(searchTerm2);
        await searchHistoryRepository.addSearchTerm(searchTerm3);

        final actualData = await SearchHistoryRepository.store.record(1).get(fakeSembastDatabase.instance);
        final actualData3 = await SearchHistoryRepository.store.record(3).get(fakeSembastDatabase.instance);

        const expectedData = searchTerm3;

        expect(actualData, null);
        expect(actualData3, expectedData);
      });
      test('does not allow more than 10 search terms in the database', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final searchHistoryRepository = SearchHistoryRepository(fakeSembastDatabase);

        const searchTerm1 = 'query1';
        const searchTerm2 = 'query2';
        const searchTerm3 = 'query3';
        const searchTerm4 = 'query4';
        const searchTerm5 = 'query5';
        const searchTerm6 = 'query6';
        const searchTerm7 = 'query7';
        const searchTerm8 = 'query8';
        const searchTerm9 = 'query9';
        const searchTerm10 = 'query10';
        const searchTerm11 = 'query11';

        await searchHistoryRepository.addSearchTerm(searchTerm1);
        await searchHistoryRepository.addSearchTerm(searchTerm2);
        await searchHistoryRepository.addSearchTerm(searchTerm3);
        await searchHistoryRepository.addSearchTerm(searchTerm4);
        await searchHistoryRepository.addSearchTerm(searchTerm5);
        await searchHistoryRepository.addSearchTerm(searchTerm6);
        await searchHistoryRepository.addSearchTerm(searchTerm7);
        await searchHistoryRepository.addSearchTerm(searchTerm8);
        await searchHistoryRepository.addSearchTerm(searchTerm9);
        await searchHistoryRepository.addSearchTerm(searchTerm10);
        await searchHistoryRepository.addSearchTerm(searchTerm11);

        final actualData = await SearchHistoryRepository.store.record(1).get(fakeSembastDatabase.instance);
        final actualData11 = await SearchHistoryRepository.store.record(11).get(fakeSembastDatabase.instance);

        const expectedData = searchTerm11;

        expect(actualData, null);
        expect(actualData11, expectedData);
      });
    });
    group('.deleteSearchTerm', () {
      test('deletes the search term in the database', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final searchHistoryRepository = SearchHistoryRepository(fakeSembastDatabase);

        const searchTerm = 'query';
        const searchTerm2 = 'test';

        await searchHistoryRepository.addSearchTerm(searchTerm);
        await searchHistoryRepository.addSearchTerm(searchTerm2);
        await searchHistoryRepository.deleteSearchTerm(searchTerm);

        final actualData = await SearchHistoryRepository.store.record(1).get(fakeSembastDatabase.instance);

        final actualData2 = await SearchHistoryRepository.store.record(2).get(fakeSembastDatabase.instance);
        const expectedData2 = searchTerm2;

        expect(actualData2, expectedData2);
        expect(actualData, null);
      });
    });
    group('.putSearchTermFirst', () {
      test('deletes and puts duplicate search term at top of queue', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final searchHistoryRepository = SearchHistoryRepository(fakeSembastDatabase);

        const searchTerm = 'query1';
        const searchTerm2 = 'query2';
        const putsSearchTerm = 'query1';

        await searchHistoryRepository.addSearchTerm(searchTerm);
        await searchHistoryRepository.addSearchTerm(searchTerm2);
        await searchHistoryRepository.putSearchTermFirst(putsSearchTerm);

        final actualData = await SearchHistoryRepository.store.record(1).get(fakeSembastDatabase.instance);

        final actualData3 = await SearchHistoryRepository.store.record(3).get(fakeSembastDatabase.instance);

        const expectedData3 = putsSearchTerm;

        expect(actualData, null);
        expect(actualData3, expectedData3);
      });
    });

    group('.watchSearchTerms', () {
      test('returns all search terms when query is null', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final searchHistoryRepository = SearchHistoryRepository(fakeSembastDatabase);

        const searchTerm1 = 'query1';
        const searchTerm2 = 'query2';
        const searchTerm3 = 'query3';

        await searchHistoryRepository.addSearchTerm(searchTerm1);
        await searchHistoryRepository.addSearchTerm(searchTerm2);
        await searchHistoryRepository.addSearchTerm(searchTerm3);

        searchHistoryRepository.watchSearchTerms().listen(
              expectAsync1(
                (event) => expect(event, <String>[searchTerm3, searchTerm2, searchTerm1]),
              ),
            );
      });
      test('returns only relevant search terms when query is null', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final searchHistoryRepository = SearchHistoryRepository(fakeSembastDatabase);

        const searchTerm1 = 'test';
        const searchTerm2 = 'query1';
        const searchTerm3 = 'query2';
        const searchTerm4 = 'test2';

        await searchHistoryRepository.addSearchTerm(searchTerm1);
        await searchHistoryRepository.addSearchTerm(searchTerm2);
        await searchHistoryRepository.addSearchTerm(searchTerm3);
        await searchHistoryRepository.addSearchTerm(searchTerm4);

        searchHistoryRepository.watchSearchTerms(filter: searchTerm1).listen(
              expectAsync1(
                (event) => expect(event, <String>[searchTerm4, searchTerm1]),
              ),
            );
      });
    });
  });
}
