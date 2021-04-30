import 'dart:async';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:hive_wrapper_annotation/hive_wrapper_annotation.dart';
import 'package:source_gen/source_gen.dart';

class BoxWrapperGenerator extends GeneratorForAnnotation<BoxWrapperAn> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final model = ModelVisitor();
    element.visitChildren(model);

    final boxName = annotation.read('boxName').objectValue.toStringValue()!;
    final boxType = annotation.read('boxType');
    var classType = '';

    if (boxType.isNull) {
      classType = '<${boxType.objectValue.toStringValue()}>';
    }

    final className = '\$${model.className}';

    final fields = _getFields(annotation);

    final buffer = StringBuffer();

    buffer.writeln('class $className extends BoxWrapper$classType {');

    // construct
    buffer.writeln('$className() : super(\'$boxName\');');
    buffer.writeln();

    // fields
    if (fields.isNotEmpty) {
      buffer.writeln('List<ValueField> fields = [');
      for (final field in fields) {
        final key = field[0];
        final def = field[1];
        final type = field[2];

        buffer.writeln('ValueField<$type>(\'$key\', $def),');
      }
      buffer.writeln('];');
      buffer.writeln();
    }

    // getters setters
    for (final a in fields) {
      final key = a[0];
      final type = a[2];

      buffer.writeln('  // $key');
      buffer.writeln('$type get $key => box.get(\'$key\') as $type;');
      buffer.writeln('set $key($type value) => box.put(\'$key\', value);');
      buffer.writeln();
    }

    // end class
    buffer.writeln('}');

    return buffer.toString();
  }

  Iterable<List<String>> _getFields(ConstantReader annotation) sync* {
    final filedsType = annotation.read('fields').objectValue.toListValue()!;

    for (final fieldType in filedsType) {
      final key = fieldType.getField('key')!.toStringValue()!;
      final defTemp = fieldType.getField('def')!;
      final def = defTemp;
      final type = def.type.toString();

      yield [key, def.toString(), type];
    }
  }
}

class ModelVisitor extends SimpleElementVisitor<void> {
  late DartType className;

  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;
  }
}
