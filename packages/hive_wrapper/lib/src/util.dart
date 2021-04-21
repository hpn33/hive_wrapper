import 'package:hive/hive.dart';

extension Hi on Box {
  Future create(String key, [dynamic def]) async {
    if (!containsKey(key)) await put(key, def);
  }

Future<void> replace(String oldName, String newName) async {
    if (containsKey(oldName)) {
      await create(newName, await get(oldName));
      await delete(oldName);
    }
  }
}
