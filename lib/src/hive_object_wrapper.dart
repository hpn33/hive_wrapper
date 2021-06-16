import 'package:hive/hive.dart';
import 'package:hive_wrapper/hive_wrapper.dart';

class HiveObjectWrapper extends HiveObject {
  Iterable<ReturnType> belongsTo<ReturnType extends HiveObjectWrapper>(
    BoxWrapper<ReturnType> relatedBox, {
    Object? Function(ReturnType)? getForeignKey,
  }) {
    return relatedBox.where((element) {
      final foreignKey =
          (getForeignKey == null ? element.key : getForeignKey(element));

      return foreignKey == key;
    });
  }

  Iterable<ReturnType> hasMany<ReturnType extends HiveObjectWrapper>(
    BoxWrapper<ReturnType> relatedBox, {
    Object? Function(ReturnType)? getForeignKey,
  }) {
    if (key == null) {
      return [];
    }

    return relatedBox.where((element) {
      final foreignKey =
          (getForeignKey == null ? element.key : getForeignKey(element));

      return foreignKey == key;
    });
  }

  ReturnType? hasOne<ReturnType extends HiveObjectWrapper>(
    BoxWrapper<ReturnType> relatedBox, {
    Object? Function(ReturnType)? getForeignKey,
  }) {
    if (key == null) {
      return null;
    }

    final selected = relatedBox.where((element) {
      final foreignKey =
          (getForeignKey == null ? element.key : getForeignKey(element));

      return foreignKey == key;
    });

    if (selected.isEmpty) {
      return null;
    }

    return selected.first;
  }

  ReturnType? hasOneThrough<ReturnType extends HiveObjectWrapper>(
    BoxWrapper<ReturnType> relatedBox,
    BoxWrapper<ReturnType> throughBox, {
    Object? Function(ReturnType)? getFirstKey,
    Object? Function(ReturnType)? getSecondKey,
  }) {
    if (key == null) {
      return null;
    }

    final selected = throughBox.where(
      (element) {
        final foreignKey =
            (getFirstKey == null ? element.key : getFirstKey(element));

        return foreignKey == key;
      },
    ).joinTo(
      relatedBox,
      (element) {
        return (getSecondKey == null ? element.key : getSecondKey(element));
      },
    );

    if (selected.isEmpty) {
      return null;
    }

    return selected.first;
  }
}
