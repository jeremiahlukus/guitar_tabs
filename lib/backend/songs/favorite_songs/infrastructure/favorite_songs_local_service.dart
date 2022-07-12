import 'package:flutter/material.dart';
import 'package:joyful_noise/backend/core/infrastructure/pagination_config.dart';
import 'package:joyful_noise/backend/core/infrastructure/song_dto.dart';
import 'package:joyful_noise/core/infrastructure/sembast_database.dart';
import 'package:sembast/sembast.dart';
import 'package:collection/collection.dart';

class FavoriteSongsLocalService {
  final SembastDatabase _sembastDatabase;

  @visibleForTesting
  static final store = intMapStoreFactory.store('favoriteSongs');

  FavoriteSongsLocalService(this._sembastDatabase);

  Future<void> upsertPage(List<SongDTO> dtos, int page) async {
    final sembastPage = page - 1;

    await store
        .records(
          dtos.mapIndexed(
            (index, _) => index + PaginationConfig.itemsPerPage * sembastPage,
          ),
        )
        .put(
          _sembastDatabase.instance,
          dtos.map((e) => e.toJson()).toList(),
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
    return records.map((e) => SongDTO.fromJson(e.value)).toList();
  }

  Future<int> getLocalPageCount() async {
    final songCount = await store.count(_sembastDatabase.instance);
    return (songCount / PaginationConfig.itemsPerPage).ceil();
  }
}
