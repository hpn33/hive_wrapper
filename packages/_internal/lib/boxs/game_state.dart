import 'package:hive_wrapper/hive_wrapper.dart';
import 'package:hive_wrapper_annotation/hive_filed.dart';
import 'package:hive_wrapper_annotation/hive_wrapper_annotation.dart';

part 'game_state.g.dart';

@BoxWrapperAn(
  boxName: 'game_state',
  fields: [
    ValueField<int>('level_score', 1),
    ValueField<int>('top_level_score', 1),
    ValueField<int>('time', 1000),
    ValueField<int>('top_score', 1),
  ],

  // migrate: [
  //   InitGameState(),
  // ],
)
class BoxGameState extends $BoxGameState {
  int get level {
    final level = levelScore ~/ 3;
    // final last = levelScore % 3;

    if (level == 0) return 1;

    return level + 1
        // (last > 0 ? 1 : 0)
        ;
  }

  set level(int value) {
    if (value < 1 || maxLevel < value) {
      return;
    }

    levelScore = (value * 3) - 2;
  }

  int get maxLevel {
    final maxLevel = topLevelScore ~/ 3;
    // final last = maxLevelScore % 3;

    if (maxLevel == 0) return 1;

    return maxLevel + 1
        // (last > 0 ? 1 : 0)
        ;
  }

  void saveLevel(int levelScore) {
    this.levelScore = levelScore;

    // save top level
    if (levelScore > topLevelScore) {
      topLevelScore = levelScore;
    }
  }
}
