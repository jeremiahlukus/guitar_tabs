// Package imports:
import 'package:joyful_noise/backend/core/infrastructure/pagination_config.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_local_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/user_dto.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_local_service.dart';
import 'package:joyful_noise/core/infrastructure/sembast_database.dart';
import 'package:collection/collection.dart';

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
          {
            'id': 50098,
            'title': 'new 1',
            'song_number': 1,
            'url': 'google',
            'artist': 'New',
            'lyrics': '[G]Down by bay, [D]Where the watermelon grows[D7] back to my home',
            'chords': '',
            'category': 'general',
          },
          {
            'id': 50099,
            'title': 'new 2',
            'song_number': 1,
            'url': 'google',
            'artist': 'New',
            'lyrics': '[G]Down by bay, [D]Where the watermelon grows[D7] back to my home',
            'chords': '',
            'category': 'general',
          }
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

        final expectedData = mockData;

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
          {
            'id': 50098,
            'title': 'new 1',
            'song_number': 1,
            'url': 'google',
            'artist': 'New',
            'lyrics': '[G]Down by bay, [D]Where the watermelon grows[D7] back to my home',
            'chords': '',
            'category': 'general',
          },
          {
            'id': 50099,
            'title': 'new 2',
            'song_number': 1,
            'url': 'google',
            'artist': 'New',
            'lyrics': '[G]Down by bay, [D]Where the watermelon grows[D7] back to my home',
            'chords': '',
            'category': 'general',
          }
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
          {
            'id': 50098,
            'title': 'new 1',
            'song_number': 1,
            'url': 'google',
            'artist': 'New',
            'lyrics': '[G]Down by bay, [D]Where the watermelon grows[D7] back to my home',
            'chords': '',
            'category': 'general',
          },
          {
            'id': 50099,
            'title': 'new 2',
            'song_number': 1,
            'url': 'google',
            'artist': 'New',
            'lyrics': '[G]Down by bay, [D]Where the watermelon grows[D7] back to my home',
            'chords': '',
            'category': 'general',
          }
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
  });
}
