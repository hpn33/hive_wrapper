import 'package:hive/hive.dart';

import 'box_wrapper.dart';
import 'hive_object_wrapper.dart';

extension BoxFunctions on Box {
  Future create(String key, [dynamic def]) async {
    if (!containsKey(key)) await put(key, def);
  }

  Future<void> rename(String oldName, String newName) async {
    if (containsKey(oldName)) {
      await create(newName, await get(oldName));
      await delete(oldName);
    }
  }
}

extension AA<R> on Iterable<R> {
  Iterable<T> joinTo<T extends HiveObjectWrapper>(
    BoxWrapper<T> targetBox,
    int? Function(R) getKey, {
    bool uniqe = false,
  }) {
    // get target keys
    final keyJoinList = <int>[];

    for (final item in this) {
      final k = getKey(item);

      if (k == null) {
        continue;
      }

      keyJoinList.add(k);
    }

    // get items
    final finalList = <T>[];

    if (keyJoinList.isEmpty) {
      return finalList;
    }

    // get match item
    final matchItem = keyJoinList.map((element) {
      for (final e in targetBox.all) {
        if (e.key == element) {
          return e;
        }
      }

      return null;
    }).where((element) => element != null);

    // finalize items
    for (final element in matchItem) {
      if (!uniqe) {
        finalList.add(element!);
        continue;
      }

      if (finalList.where((e) => e.key == element!.key).isEmpty) {
        finalList.add(element!);
        continue;
      }
    }

    return finalList;
  }
}
