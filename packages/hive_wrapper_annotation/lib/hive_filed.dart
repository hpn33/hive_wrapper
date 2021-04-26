class ValueField<T> {
  const ValueField(this.key, [this.def]);

  final String key;
  // final  Type type = T;
  final T? def;
}

// class IntField extends ValueField<int> {
//   IntField(String key, [int? def]) : super(key, def);
// }
