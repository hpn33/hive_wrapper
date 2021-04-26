import 'boxs/game_state.dart';
import 'boxs/scores.dart';
import 'type/score_type.dart';
import 'wrapper.g.dart';

import 'package:hive_wrapper_annotation/hive_wrapper_annotation.dart';

final hiveW = HiveWrapper();

@HiveWrapperAn(
  boxs: [BoxGameState, BoxScores],
)
class HiveWrapper extends $HiveWrapper {
  void saveScore(int score) {
    scores.box.add(
      Score()
        ..score = score
        ..date = DateTime.now(),
    );

    // save top score
    if (score > gameState.topScore) {
      gameState.topScore = score;
    }
  }
}
