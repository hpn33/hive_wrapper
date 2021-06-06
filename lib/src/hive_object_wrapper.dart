import 'package:hive/hive.dart';
import 'package:hive_wrapper/hive_wrapper.dart';

class HiveObjectWrapper extends HiveObject {
  Iterable<ReturnType> belongsTo<ReturnType extends HiveObjectWrapper>(
    BoxWrapper<ReturnType> relatedBox, {
    Object? ownerKey,
    Object? Function(ReturnType)? getForeignKey,
  }) {
    final _key = (ownerKey ?? key);

    return relatedBox.where((element) {
      final foreignKey =
          (getForeignKey == null ? element.key : getForeignKey(element));

      return foreignKey == _key;
    });
  }

  Iterable<ReturnType> hasMany<ReturnType extends HiveObjectWrapper>(
    BoxWrapper<ReturnType> relatedBox, {
    Object? ownerKey,
    Object? Function(ReturnType)? getForeignKey,
  }) {
    if (key == null) {
      return [];
    }

    final _key = (ownerKey ?? key);

    return relatedBox.where((element) {
      final foreignKey =
          (getForeignKey == null ? element.key : getForeignKey(element));

      return foreignKey == _key;
    });
  }

  ReturnType? hasOne<ReturnType extends HiveObjectWrapper>(
    BoxWrapper<ReturnType> relatedBox, {
    Object? ownerKey,
    Object? Function(ReturnType)? getForeignKey,
  }) {
    if (key == null) {
      return null;
    }

    final _key = (ownerKey ?? key);

    final selected = relatedBox.where((element) {
      final foreignKey =
          (getForeignKey == null ? element.key : getForeignKey(element));

      return foreignKey == _key;
    });

    if (selected.isEmpty) {
      return null;
    }

    return selected.first;
  }

  ReturnType? hasOneThrough<ReturnType extends HiveObjectWrapper>(
    BoxWrapper<ReturnType> relatedBox,
    BoxWrapper<ReturnType> throughBox, {
    Object? ownerKey,
    Object? Function(ReturnType)? getFirstKey,
    Object? Function(ReturnType)? getSecondKey,
  }) {
    if (key == null) {
      return null;
    }

    final _key = (ownerKey ?? key);

    final selected = throughBox.where(
      (element) {
        final foreignKey =
            (getFirstKey == null ? element.key : getFirstKey(element));

        return foreignKey == _key;
      },
    ).joinTo(
      relatedBox,
      (element) => (getSecondKey == null ? element.key : getSecondKey(element)),
    );

    if (selected.isEmpty) {
      return null;
    }

    return selected.first;
  }
}
