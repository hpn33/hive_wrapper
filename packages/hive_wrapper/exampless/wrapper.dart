import 'package:hive/hive.dart';
import 'package:hive_wrapper/hive_wrapper.dart';

import 'type/score_type.dart';
import 'wrapper.g.dart';

// import 'filed.dart';
// import 'type/score_type.dart';

final hiveW = HiveWrapper();

@HiveWrapper(
  boxs: [
    BoxGameState,
    BoxScores,
  ],
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
