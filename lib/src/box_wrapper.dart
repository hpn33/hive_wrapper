import 'package:hive/hive.dart';

typedef BoxMigrationFunc<Type> = Future<void> Function(Box<Type>, int?);

abstract class BoxWrapper<Type> {
  final String boxName;
  // use a different box for saving version
  final int _buildVersion;
  final String versionName = '__version__';

  final Map<int, BoxMigrationFunc> migrations;

  BoxWrapper(this.boxName, this._buildVersion, this.migrations);

  // access to box
  Box<Type> get box => Hive.box<Type>(boxName);

  Future<void> load() async {
    // version check
    int? existVersion;

    final setting = await Hive.openBox(boxName);

    if (!setting.containsKey(versionName)) {
      await setting.put(versionName, _buildVersion);
      existVersion = _buildVersion;
    } else {
      existVersion = setting.get(versionName);
    }

    await setting.close();

    // if not exist create last migrate
    if (existVersion == -1) {
      final box = await Hive.openBox<Type>(boxName);

      migrations.forEach((key, value) async {
        await value.call(box, existVersion);
        existVersion = key;
      });

      return;
    }

    // if same open
    if (existVersion == _buildVersion) {
      await Hive.openBox<Type>(boxName);
      return;
    }

// if less migrate
    existVersion!;

    if (existVersion < _buildVersion) {
      await Hive.openBox<Type>(boxName);

      for (var i = existVersion; i < migrations.length; i++) {
        await migrations[i + 1]!.call(box, existVersion);
        existVersion = i + 1;
      }

      return;
    }

// if more ???

//
    // await initBox(box);
  }

  Future<void> initBox(Box<Type> box);

  Future<int> clear() => box.clear();

  Iterable<Type> get all => box.values;

  Iterable<Type> where(bool Function(Type element) _where) => all.where(_where);
}
