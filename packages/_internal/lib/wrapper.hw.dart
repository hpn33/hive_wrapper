// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrapper.dart';

// **************************************************************************
// HiveWrapperGenerator
// **************************************************************************

class $HiveWrapper {
  final gameState = BoxGameState();
  final scores = BoxScores();

  Future<void> loadHive() async {
    await Hive.initFlutter();

    await gameState.load();
    await scores.load();
  }
}
