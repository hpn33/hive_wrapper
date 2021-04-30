import 'boxs/game_state.dart';
import 'boxs/scores.dart';
import 'type/score_type.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:hive_wrapper_annotation/hive_wrapper_annotation.dart';

part 'wrapper.hw.dart';

final hiveW = HiveWrapper();

@HiveWrapperAn(
  boxs: [BoxGameState, BoxScores],
  // adaptors: [ScoreAdapter],
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
