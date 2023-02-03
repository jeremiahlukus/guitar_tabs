// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:sembast/sembast.dart';

// Project imports:
import 'package:joyful_noise/core/infrastructure/sembast_database.dart';

class SearchHistoryRepository {
  final SembastDatabase _sembastDatabase;

  @visibleForTesting
  static final store = StoreRef<int, String>('searchHistory');

  SearchHistoryRepository(this._sembastDatabase);

  static const historyLength = 10;

  Stream<List<String>> watchSearchTerms({String? filter}) {
    return store
        .query(
          finder: filter != null && filter.isNotEmpty
              ? Finder(
                  filter: Filter.custom(
                    // ignore: cast_nullable_to_non_nullable
                    (record) => (record.value as String).startsWith(filter),
                  ),
                )
              : null,
        )
        .onSnapshots(_sembastDatabase.instance)
        .map((records) => records.reversed.map((e) => e.value).toList());
  }

  Future<void> addSearchTerm(String term) => _addSearchTerm(term, _sembastDatabase.instance);

  Future<void> deleteSearchTerm(String term) => _deleteSearchTerm(term, _sembastDatabase.instance);

  Future<void> putSearchTermFirst(String term) async {
    await _sembastDatabase.instance.transaction((transaction) async {
      await _deleteSearchTerm(term, transaction);
      await _addSearchTerm(term, transaction);
    });
  }

  Future<void> _addSearchTerm(String term, DatabaseClient dbClient) async {
    final existingKey = await store.findKey(
      dbClient,
      finder: Finder(
        filter: Filter.custom((record) => record.value == term),
      ),
    );

    if (existingKey != null) {
      await putSearchTermFirst(term);
      return;
    }

    await store.add(dbClient, term);
    final count = await store.count(dbClient);
    if (count > historyLength) {
      await store.delete(
        dbClient,
        finder: Finder(limit: count - historyLength),
        // [least, most]
      );
    }
  }

  Future<void> _deleteSearchTerm(String term, DatabaseClient dbClient) async {
    await store.delete(
      dbClient,
      finder: Finder(
        filter: Filter.custom((record) => record.value == term),
      ),
    );
  }
}
