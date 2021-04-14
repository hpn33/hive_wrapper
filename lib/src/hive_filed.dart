import 'package:hive/hive.dart';

class ValueField<T> {
  final String key;
  final T? def;

  ValueField(this.key, [this.def]);

  Future<void> create(Box box) async {
    if (!box.containsKey(key)) await box.put(key, def as T);
  }
}

class IntField extends ValueField<int> {
  IntField(String key, [int? def]) : super(key, def);
}
