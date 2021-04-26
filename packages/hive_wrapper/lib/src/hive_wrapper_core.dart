import 'package:hive/hive.dart';

import 'hive_filed.dart';

export 'util.dart';

abstract class BoxWrapper<Type> {
  final String boxName;

  BoxWrapper(this.boxName);

  // access to box
  Box<Type> get box => Hive.box<Type>(boxName);

  List<ValueField> fields = [];

  // List<HiveMigration> migrations = [];

  Future<void> load() async {
    final box = await Hive.openBox<Type>(boxName);

    fields.forEach((element) => element.create(box));
    await initBox(box);

    // migrations.forEach((element) => element.migrate(box));
  }

  Future<void> initBox(Box box) async {
    for (final field in fields) {
      field.create(box);
    }
  }

  // Future<void> initBox(Box<Type> box);

  Future<int> clear() => box.clear();

  Iterable<Type> get all => box.values;

  Iterable<Type> where(bool Function(Type element) _where) => all.where(_where);
}
