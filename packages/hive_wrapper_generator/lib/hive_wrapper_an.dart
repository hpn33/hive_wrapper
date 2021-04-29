import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:hive_wrapper_annotation/hive_wrapper_annotation.dart';
import 'package:source_gen/source_gen.dart';

class HiveWrapperGenerator extends GeneratorForAnnotation<HiveWrapperAn> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final model = ModelVisitor();
    element.visitChildren(model);

    final fields = _getFields(annotation);
    final adaptors = _getAdaptors(annotation);

    final buffer = StringBuffer();

    buffer.writeln('class \$${model.className} {');

    // fields
    for (final field in fields) {
      final type = field[0];
      final name = field[1];

      buffer.writeln('$type $name = $type();');
    }
    buffer.writeln();

    // loadHive
    buffer.writeln('Future<void> loadHive() async {');
    buffer.writeln('await Hive.initFlutter();');
    buffer.writeln();

    // register Adapters
    for (final adaptor in adaptors) {
      buffer.writeln('Hive.registerAdapter($adaptor());');
    }
    buffer.writeln();

    // load boxs
    for (final field in fields) {
      buffer.writeln('await ${field[1]}.load();');
    }
    buffer.writeln('}');
    buffer.writeln();

    // end class
    buffer.writeln('}');

    return buffer.toString();
  }

  Iterable<List<String>> _getFields(ConstantReader annotation) sync* {
    final boxTypes = annotation.read('boxs').objectValue.toListValue()!;

    for (final box in boxTypes) {
      final type = box.toTypeValue().toString().replaceAll('*', '');

      final name =
          type.substring(3, 4).toLowerCase() + type.substring(4, type.length);

      yield [type, name];
    }
  }

  Iterable<String> _getAdaptors(ConstantReader annotation) sync* {
    final adaptorTypes = annotation.read('adaptors').objectValue.toListValue()!;

    for (final adaptor in adaptorTypes) {
      // type
      yield adaptor.toTypeValue().toString().replaceAll('*', '');
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
