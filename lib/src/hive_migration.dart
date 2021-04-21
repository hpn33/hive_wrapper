import 'package:hive/hive.dart';

abstract class HiveMigration<BoxType> {
  void migrate(Box<BoxType> box);
}

extension HMigrate<T> on Box {
  Future<void> field<T>(String key, T def) async {
    if (!this.containsKey(key)) await this.put(key, def);
  }
}
