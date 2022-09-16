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
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_remote_service.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_repository.dart';
import 'package:joyful_noise/backend/songs/song_detail/notifiers/song_detail_notifier.dart';
import 'package:joyful_noise/core/infrastructure/sembast_database.dart';

final sembastProvider = Provider((ref) => SembastDatabase());

final dioProvider = Provider((ref) => Dio());

final backendHeadersCacheProvider = Provider(
  (ref) => BackendHeadersCache(ref.watch(sembastProvider)),
);
