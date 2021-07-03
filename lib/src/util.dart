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

      if (k != null) {
        keyJoinList.add(k);
      }
    }

    // if no keys exists
    if (keyJoinList.isEmpty) {
      return [];
    }

    // get match item
    final matchList = <T>[];
    final _targetBox = targetBox.all.cast<T?>();

    for (final keyJoinItem in keyJoinList) {
      final target = _targetBox.firstWhere(
        (targetItem) => targetItem!.key == keyJoinItem,
        orElse: () => null,
      );

      if (target != null) {
        matchList.add(target);
      }
    }

    // if uniqe was false
    if (!uniqe) {
      return matchList;
    }

    // finalize items
    final finalList = <T>[];

    for (final element in matchList) {
      if (!finalList.any((e) => e.key == element.key)) {
        finalList.add(element);
      }
    }

    return finalList;
  }
}
