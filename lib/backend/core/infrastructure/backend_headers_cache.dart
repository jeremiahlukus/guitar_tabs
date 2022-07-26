// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:sembast/sembast.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_headers.dart';
import 'package:joyful_noise/core/infrastructure/sembast_database.dart';

class BackendHeadersCache {
  final SembastDatabase _sembastDatabase;
  @visibleForTesting
  static final store = stringMapStoreFactory.store('headers');

  BackendHeadersCache(this._sembastDatabase);

  Future<void> saveHeaders(Uri uri, BackendHeaders headers) async {
    await store.delete(_sembastDatabase.instance);
    await store.record(uri.toString()).put(
          _sembastDatabase.instance,
          headers.toJson(),
        );
  }

  Future<BackendHeaders?> getHeaders(Uri uri) async {
    await store.delete(_sembastDatabase.instance);
    final json = await store.record(uri.toString()).get(_sembastDatabase.instance);
    return json == null ? null : BackendHeaders.fromJson(json);
  }

  Future<void> deleteHeaders(Uri uri) async {
    await store.record(uri.toString()).delete(_sembastDatabase.instance);
  }
}
