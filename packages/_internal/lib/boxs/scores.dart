import 'package:hive_wrapper/hive_wrapper.dart';
import 'package:hive_wrapper_annotation/hive_wrapper_annotation.dart';

import '../type/score_type.dart';

part 'scores.g.dart';

@BoxWrapperAn(
  boxName: 'scores',
  boxType: Score,
)
class BoxScores extends $BoxScores {}
