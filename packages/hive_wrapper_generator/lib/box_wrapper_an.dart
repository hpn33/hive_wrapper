import 'dart:async';

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
    final buffer = StringBuffer();

    buffer.writeln('class $className extends BoxWrapper$classType {');

    // construct
    buffer.writeln('$className() : super(\'$boxName\')');

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
