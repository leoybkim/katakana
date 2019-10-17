import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:katakana/core/repositories/kana_repository.dart';
import 'package:katakana/kana/kana_bloc.dart';
import 'package:katakana/utils/disk_asset_bundle.dart';

final locator = GetIt.instance..allowReassignment = true;

//Simple Get_It class for DI.
registerServices() {
  locator.registerSingleton<KanaRepository>(KanaRepository()); // register a singleton instance of KanaRepository for the app
}
