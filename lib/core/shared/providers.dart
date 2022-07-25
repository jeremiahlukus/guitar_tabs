// Package imports:
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_headers_cache.dart';
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_local_service.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_remote_service.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_remote_service.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_repository.dart';
import 'package:joyful_noise/backend/songs/searched_songs/notifiers/searched_songs_notifier.dart';
import 'package:joyful_noise/core/infrastructure/sembast_database.dart';

final sembastProvider = Provider((ref) => SembastDatabase());

final dioProvider = Provider((ref) => Dio());

final backendHeadersCacheProvider = Provider(
  (ref) => BackendHeadersCache(ref.watch(sembastProvider)),
);

// favoriteSongs
final favoriteSongsLocalServiceProvider = Provider(
  (ref) => FavoriteSongsLocalService(ref.watch(sembastProvider)),
);

final favoriteSongsRemoteServiceProvider = Provider(
  (ref) => FavoriteSongsRemoteService(
    ref.watch(dioProvider),
    ref.watch(backendHeadersCacheProvider),
  ),
);

final favoriteSongsRepositoryProvider = Provider(
  (ref) => FavoriteSongsRepository(
    ref.watch(favoriteSongsRemoteServiceProvider),
    ref.watch(favoriteSongsLocalServiceProvider),
  ),
);

final favoriteSongsNotifierProvider = StateNotifierProvider.autoDispose<FavoriteSongNotifier, PaginatedSongsState>(
  (ref) => FavoriteSongNotifier(ref.watch(favoriteSongsRepositoryProvider)),
);

final searchedSongsRemoteServiceProvider = Provider(
  (ref) => SearchedSongsRemoteService(
    ref.watch(dioProvider),
    ref.watch(backendHeadersCacheProvider),
  ),
);

final searchedSongsRepositoryProvider = Provider(
  (ref) => SearchedSongsRepository(
    ref.watch(searchedSongsRemoteServiceProvider),
  ),
);

final searchedSongsNotifierProvider = StateNotifierProvider.autoDispose<SearchedSongsNotifier, PaginatedSongsState>(
  (ref) => SearchedSongsNotifier(ref.watch(searchedSongsRepositoryProvider)),
);
