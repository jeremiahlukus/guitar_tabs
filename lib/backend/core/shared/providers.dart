// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_headers_cache.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_local_service.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_remote_service.dart';
import 'package:joyful_noise/backend/core/infrastructure/user_repository.dart';
import 'package:joyful_noise/backend/core/notifiers/user_notifier.dart';
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
