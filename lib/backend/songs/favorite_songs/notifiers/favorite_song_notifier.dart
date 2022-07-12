import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/infrastructure/favorite_songs_repository.dart';

class FavoriteSongNotifier extends PaginatedSongsNotifier {
  final FavoriteSongsRepository _repository;

  FavoriteSongNotifier(this._repository);

  Future<void> getFirstFavoriteSongsPage() async {
    super.resetState();
    await getNextFavoriteSongsPage();
  }

  Future<void> getNextFavoriteSongsPage() async {
    await super.getNextPage(_repository.getFavoritePage);
  }
}
