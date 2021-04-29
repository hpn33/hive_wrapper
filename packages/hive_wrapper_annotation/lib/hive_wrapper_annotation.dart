import 'hive_filed.dart';

class BoxWrapperAn {
  const BoxWrapperAn({
    this.boxName = '',
    this.boxType = dynamic,
    this.fields = const [],
  });

  final String boxName;

  // List<HiveMigration> migrations = [];

  final Type boxType;

  final List<ValueField> fields;
}

class HiveWrapperAn {
  const HiveWrapperAn({
    this.boxs = const [],
    this.adaptors = const [],
  });

  final List<Type> boxs;
  final List<Type> adaptors;
}
