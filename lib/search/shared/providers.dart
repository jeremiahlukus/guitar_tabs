// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:joyful_noise/core/shared/providers.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';
import 'package:joyful_noise/search/notifiers/search_history_notifier.dart';

final searchHistoryRepositoryProvider = Provider(
  (ref) => SearchHistoryRepository(ref.watch(sembastProvider)),
);

final searchHistoryNotifierProvider = StateNotifierProvider<SearchHistoryNotifier, AsyncValue<List<String>>>(
  (ref) => SearchHistoryNotifier(
    ref.watch(searchHistoryRepositoryProvider),
  ),
);
