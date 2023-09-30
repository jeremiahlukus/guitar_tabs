// Package imports:
import 'package:collection/collection.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/pagination_config.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_local_service.dart';
import 'package:joyful_noise/core/infrastructure/sembast_database.dart';
import '../../../../_mocks/song/mock_song.dart';

class FakeSembastDatabase extends Fake implements SembastDatabase {
  FakeSembastDatabase(this._database);
  final Database _database;

  @override
  Database get instance => _database;
}

void main() {
  group('FavoriteSongsLocalService', () {
    group('.upsertPage', () {
      test('stores the List<Song> objects in the database', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final favoriteSongLocalService = FavoriteSongsLocalService(fakeSembastDatabase);

        final mockData = [
          mockSongJson(1),
          mockSongJson(2),
        ];

        final convertedData = [SongDTO.fromJson(mockData.first), SongDTO.fromJson(mockData.last)];
        const page = 1;
        await favoriteSongLocalService.upsertPage(convertedData, page);
        const sembastPage = page - 1;
        final actualData = await FavoriteSongsLocalService.store
            .records(
              convertedData.mapIndexed(
                (index, _) => index + PaginationConfig.itemsPerPage * sembastPage,
              ),
            )
            .get(fakeSembastDatabase.instance);

        final expectedData = [
          mockSongStrippedJson(1),
          mockSongStrippedJson(2),
        ];

        expect(actualData, expectedData);
      });
    });

    group('.getPage', () {
      test('gets the current page of List<Song> object in the database', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final favoriteSongLocalService = FavoriteSongsLocalService(fakeSembastDatabase);

        final mockData = [
          mockSongJson(1),
          mockSongJson(2),
        ];

        final convertedData = [SongDTO.fromJson(mockData.first), SongDTO.fromJson(mockData.last)];
        const page = 1;
        const sembastPage = page - 1;
        await FavoriteSongsLocalService.store
            .records(
              convertedData.mapIndexed(
                (index, _) => index + PaginationConfig.itemsPerPage * sembastPage,
              ),
            )
            .put(fakeSembastDatabase.instance, mockData);

        final actualData = await favoriteSongLocalService.getPage(page);

        final expectedData = convertedData;

        expect(actualData, expectedData);
      });
    });

    group('.getLocalPageCount', () {
      test('gets the local page count integer', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final favoriteSongLocalService = FavoriteSongsLocalService(fakeSembastDatabase);
        final mockData = [
          mockSongJson(1),
          mockSongJson(2),
        ];

        final convertedData = [SongDTO.fromJson(mockData.first), SongDTO.fromJson(mockData.last)];
        const page = 1;
        const sembastPage = page - 1;
        await FavoriteSongsLocalService.store
            .records(
              convertedData.mapIndexed(
                (index, _) => index + PaginationConfig.itemsPerPage * sembastPage,
              ),
            )
            .put(fakeSembastDatabase.instance, mockData);

        await favoriteSongLocalService.getLocalPageCount();

        final actualData = await favoriteSongLocalService.getLocalPageCount();

        const expectedData = page;

        expect(actualData, expectedData);
      });
    });

    group('.searchLocalSongs', () {
      test('searches the current List<Song> object in the database', () async {
        final factory = newDatabaseFactoryMemory();

        final memoryDatabase = await factory.openDatabase('test.db');

        final SembastDatabase fakeSembastDatabase = FakeSembastDatabase(memoryDatabase);

        final favoriteSongLocalService = FavoriteSongsLocalService(fakeSembastDatabase);
        final mockData = [mockSongJson(1), mockSongJson(2), mockSongJson2(3)];

        final convertedData = [
          SongDTO.fromJson(mockData.first),
          SongDTO.fromJson(mockData[1]),
          SongDTO.fromJson(mockData.last),
        ];
        const page = 1;
        const sembastPage = page - 1;
        await FavoriteSongsLocalService.store
            .records(
              convertedData.mapIndexed(
                (index, _) => index + PaginationConfig.itemsPerPage * sembastPage,
              ),
            )
            .put(fakeSembastDatabase.instance, mockData);

        final actualData = await favoriteSongLocalService.searchLocalSongs('test');

        expect(actualData, [convertedData.last]);
      });
    });
  });
}
