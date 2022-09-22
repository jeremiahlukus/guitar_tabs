// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:sembast/sembast.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/pagination_config.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/core/infrastructure/sembast_database.dart';

class FavoriteSongsLocalService {
  final SembastDatabase _sembastDatabase;

  @visibleForTesting
  static final store = intMapStoreFactory.store('favoriteSongs');

  FavoriteSongsLocalService(this._sembastDatabase);

  Future<void> upsertPage(List<SongDTO> dtos, int page) async {
    final sembastPage = page - 1;
    final nonDuplicatedDto = dtos.toSet().toList();
    await store
        .records(
          nonDuplicatedDto.mapIndexed(
            (index, _) => index + PaginationConfig.itemsPerPage * sembastPage,
          ),
        )
        .put(
          _sembastDatabase.instance,
          nonDuplicatedDto.map((e) => e.toJson()).toList(),
        );
  }

  Future<List<SongDTO>> getPage(int page) async {
    final sembastPage = page - 1;

    final records = await store.find(
      _sembastDatabase.instance,
      finder: Finder(
        limit: PaginationConfig.itemsPerPage,
        offset: PaginationConfig.itemsPerPage * sembastPage,
      ),
    );
    return records.map((e) => SongDTO.fromJson(e.value)).toSet().toList();
  }

  Future<List<SongDTO>> searchLocalSongs(String query) async {
    final finder = Finder(filter: Filter.matches('lyrics', query));
    final records = await store.find(_sembastDatabase.instance, finder: finder);
    return records.map((e) => SongDTO.fromJson(e.value)).toSet().toList();
  }

  Future<int> getLocalPageCount() async {
    final songCount = await store.count(_sembastDatabase.instance);
    return (songCount / PaginationConfig.itemsPerPage).ceil();
  }
}
