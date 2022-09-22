// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_headers_cache.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_local_service.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_remote_service.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_repository.dart';
import 'package:joyful_noise/backend/core/notifiers/user_notifier.dart';
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_local_service.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_remote_service.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_remote_service.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_repository.dart';
import 'package:joyful_noise/backend/songs/searched_songs/notifiers/searched_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_remote_service.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_repository.dart';
import 'package:joyful_noise/backend/songs/song_detail/notifiers/song_detail_notifier.dart';
import 'package:joyful_noise/core/shared/providers.dart';

final backendHeadersCacheProvider = Provider(
  (ref) => BackendHeadersCache(ref.watch(sembastProvider)),
);

final userLocalServiceProvider = Provider(
  (ref) => UserLocalService(ref.watch(sembastProvider)),
);

final userRemoteServiceProvider = Provider(
  (ref) => UserRemoteService(
    ref.watch(dioProvider),
    ref.watch(backendHeadersCacheProvider),
  ),
);

final userRepositoryProvider = Provider(
  (ref) => UserRepository(
    ref.watch(userRemoteServiceProvider),
    ref.watch(userLocalServiceProvider),
  ),
);

final userNotifierProvider = StateNotifierProvider.autoDispose<UserNotifier, UserState>(
  (ref) => UserNotifier(ref.watch(userRepositoryProvider)),
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
    ref.watch(favoriteSongsLocalServiceProvider),
  ),
);

final searchedSongsNotifierProvider = StateNotifierProvider.autoDispose<SearchedSongsNotifier, PaginatedSongsState>(
  (ref) => SearchedSongsNotifier(ref.watch(searchedSongsRepositoryProvider)),
);

final songDetailRemoteServiceProvider = Provider(
  (ref) => SongDetailRemoteService(
    ref.watch(dioProvider),
  ),
);

final songDetailRepositoryProvider = Provider(
  (ref) => SongDetailRepository(
    ref.watch(songDetailRemoteServiceProvider),
  ),
);

final songDetailNotifierProvider = StateNotifierProvider.autoDispose<SongDetailNotifier, SongDetailState>(
  (ref) => SongDetailNotifier(ref.watch(songDetailRepositoryProvider)),
);
