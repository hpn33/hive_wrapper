import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'box_wrapper_an.dart';
import 'hive_wrapper_an.dart';

/// Builds generators for `build_runner` to run
Builder hiveWrapperAn(BuilderOptions options) {
  // return MultiplexingBuilder(
  //   [
  //     PartBuilder(
  //       [HiveWrapperGenerator()],
  //       '.hw.dart',
  //     ),
  //     PartBuilder(
  //       [BoxWrapperGenerator()],
  //       '.hw.dart',
  //     ),
  //   ],
  // );
  return PartBuilder(
    [
      HiveWrapperGenerator(),
      BoxWrapperGenerator(),
    ],
    '.hw.dart',
  );
}

// Builder boxWrapperAn(BuilderOptions options) {
//   return PartBuilder(
//     [BoxWrapperGenerator()],
//     '.g.dart',
//   );
// }
