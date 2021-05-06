import 'package:hive/hive.dart';
export 'util.dart';

abstract class BoxWrapper<Type> {
  final String boxName;

  BoxWrapper(this.boxName);

  // access to box
  Box<Type> get box => Hive.box<Type>(boxName);

  Future<void> load() async {
    final box = await Hive.openBox<Type>(boxName);
    await initBox(box);
  }

  Future<void> initBox(Box<Type> box);

  Future<int> clear() => box.clear();

  Iterable<Type> get all => box.values;

  Iterable<Type> where(bool Function(Type element) _where) => all.where(_where);
}
