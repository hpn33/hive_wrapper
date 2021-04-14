import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'boxs/game_state.dart';
import 'boxs/scores.dart';
import 'type/score_type.dart';

class $HiveWrapper {
  final gameState = BoxGameState();
  final scores = BoxScores();

  Future<void> loadHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ScoreAdapter());

    await gameState.load();
    await scores.load();
  }
}
