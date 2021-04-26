import 'package:hive/hive.dart';

part 'score_type.g.dart';

@HiveType(typeId: 0)
class Score extends HiveObject {
  @HiveField(0)
  late int score;

  @HiveField(1)
  late DateTime date;
}
