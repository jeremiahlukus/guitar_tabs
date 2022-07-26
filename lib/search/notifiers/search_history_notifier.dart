import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';
import 'package:joyful_noise/search/infrastructure/search_history_repository.dart';

class SearchHistoryNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final SearchHistoryRepository _repository;

  SearchHistoryNotifier(this._repository) : super(const AsyncValue.loading());

  void watchSearchTerms({String? filter}) {
    _repository.watchSearchTerms(filter: filter).listen(
      (data) {
        logger.e('Success');
        state = AsyncValue.data(data);
      },
      onError: (Object error) {
        logger.e('Error');
        state = AsyncValue.error(error);
      },
    );
  }

  Future<void> addSearchTerm(String term) => _repository.addSearchTerm(term);

  Future<void> deleteSearchTerm(String term) => _repository.deleteSearchTerm(term);

  Future<void> putSearchTermFirst(String term) => _repository.putSearchTermFirst(term);
}
