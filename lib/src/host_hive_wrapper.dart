import 'box_wrapper.dart';
import 'hive_object_wrapper.dart';

abstract class HostHiveWrapper {
  late Map<String, BoxWrapper> boxs;

  BoxWrapper<BoxType> getBox<BoxType>(String boxName) {
    return boxs[boxName] as BoxWrapper<BoxType>;
  }

  Iterable<ReturnType> belongsTo<ReturnType extends HiveObjectWrapper>(
    int localKey,
    BoxWrapper<ReturnType> targetBox,
    String targetField,
  ) {
    return targetBox.where((element) {
      final field = element.getField(targetField);

      return field == localKey;
    });
  }

  Iterable<ReturnType> hasMany<ReturnType extends HiveObjectWrapper>(
    BoxWrapper<ReturnType> targetBox,
    int? localKey,
  ) {
    if (localKey == null) {
      return [];
    }

    return targetBox.where((element) => element.key == localKey);
  }

  ReturnType? hasOne<ReturnType extends HiveObjectWrapper>(
    BoxWrapper<ReturnType> targetBox,
    int? localKey,
  ) {
    if (localKey == null) {
      return null;
    }

    final selected = targetBox.where((element) => element.key == localKey);

    if (selected.isEmpty) {
      return null;
    }

    return selected.first;
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
    final uniqeList = <T>[];

    targetBox.where((element) {
      if (keyJoinList.isEmpty) {
        return false;
      }

      for (final i in keyJoinList) {
        if (element.key == i) {
          continue;
        }

        keyJoinList.remove(i);

        if (!uniqe) {
          return true;
        }

        if (uniqeList.where((e) => e.key == element.key).isEmpty) {
          return true;
        }
      }

      return false;
    });

    return uniqeList;
  }
}
