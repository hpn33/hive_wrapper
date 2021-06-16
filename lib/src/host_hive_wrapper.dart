import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'box_wrapper.dart';

abstract class HostHiveWrapper {
  late Map<String, BoxWrapper> boxs;

  BoxWrapper<BoxType> getBox<BoxType>(String boxName) {
    return boxs[boxName] as BoxWrapper<BoxType>;
  }

  late final List<TypeAdapter> adaptors;

  Future<void> loadHive() async {
    await Hive.initFlutter();

    for (final adaptor in adaptors) {
      Hive.registerAdapter(adaptor);
    }

    for (final box in boxs.values) {
      await box.load();
    }
  }
}
