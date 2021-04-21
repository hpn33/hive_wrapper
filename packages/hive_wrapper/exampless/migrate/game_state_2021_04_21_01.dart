import 'package:hive/hive.dart';
import 'package:hive_wrapper/src/hive_migration.dart';

import '../boxs/game_state.dart';

// @HiveMigrate
class InitGameState extends HiveMigration {
  @override
  void migrate(Box box) {
    box.field('level_score', 1);
    box.field('top_level_score', 1);
    box.field('time', 1000);
    box.field('top_score', 1);
  }
}
