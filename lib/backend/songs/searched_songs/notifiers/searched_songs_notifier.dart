import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/searched_songs/infrastructure/searched_songs_repository.dart';

class SearchedSongsNotifier extends PaginatedSongsNotifier {
  final SearchedSongsRepository _repository;

  SearchedSongsNotifier(this._repository);

  Future<void> getFirstSearchedSongsPage(String query) async {
    super.resetState();
    await getNextSearchedSongsPage(query);
  }

  Future<void> getNextSearchedSongsPage(String query) async {
    await super.getNextPage((page) => _repository.getSearchedSongsPage(query, page));
  }
}
