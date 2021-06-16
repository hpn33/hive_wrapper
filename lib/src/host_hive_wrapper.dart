import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'box_wrapper.dart';

abstract class HostHiveWrapper {
  late List<BoxWrapper> boxs;

  Future<void> loadHive() async {
    await Hive.initFlutter();

    await registerAdapter();

    for (final box in boxs) {
      await box.load();
    }
  }

  // function to registerAdapters
  Future<void> registerAdapter();
}
