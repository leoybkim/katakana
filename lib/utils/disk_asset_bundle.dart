import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glob/glob.dart';

/// A simple implementation of [AssetBundle] that reads files from an asset dir.
///
/// This is meant to be similar to the default [rootBundle] for testing.
class DiskAssetBundle extends CachingAssetBundle {
  static const _assetManifestDotJson = 'AssetManifest.json';

  /// Creates a [DiskAssetBundle] by loading [globs] of assets under `assets/`.
  static Future<AssetBundle> loadGlob(
    Iterable<String> globs, {
    String from = 'assets',
  }) async {
    final cache = <String, ByteData>{};
    for (final pattern in globs) {
      await for (final path in Glob(pattern).list(root: from)) {
        if (path is File) {
          final bytes = await path.readAsBytes();
          cache[path.path.replaceAll('\\', '/')] = ByteData.view(bytes.buffer);
        }
      }
    }
    final manifest = <String, List<String>>{};
    cache.forEach((key, _) {
      manifest[key] = [key];
    });

    cache[_assetManifestDotJson] = ByteData.view(
      Uint8List.fromList(jsonEncode(manifest).codeUnits).buffer,
    );

    return DiskAssetBundle._(cache);
  }

  final Map<String, ByteData> _cache;

  DiskAssetBundle._(this._cache);

  @override
  Future<ByteData> load(String key) async {
    return _cache[key];
  }

  bool assetExistsAt(String key){
    return _cache.containsKey(key);
  }

  @override
  Future<T> loadStructuredData<T>(
          String key, Future<T> Function(String) parser) async =>
      await parser(utf8.decode(_cache[key].buffer.asUint8List().cast<int>()));
}
