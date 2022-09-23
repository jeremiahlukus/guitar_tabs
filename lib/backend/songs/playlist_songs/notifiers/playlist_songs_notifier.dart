// Project imports:
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/infrastructure/playlist_songs_repository.dart';

class PlaylistSongsNotifier extends PaginatedSongsNotifier {
  final PlaylistSongsRepository _repository;

  PlaylistSongsNotifier(this._repository);

  Future<void> getFirstPlaylistSongsPage(String playlistName) async {
    super.resetState();
    await getNextPlaylistSongsPage(playlistName);
  }

  Future<void> getNextPlaylistSongsPage(String playlistName) async {
    await super.getNextPage((page) => _repository.getPlaylistSong(page, playlistName));
  }
}
