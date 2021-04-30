// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// BoxWrapperGenerator
// **************************************************************************

class $BoxGameState extends BoxWrapper {
  $BoxGameState() : super('game_state');

  List<ValueField> fields = [
    ValueField<int>('levelScore', int(1)),
    ValueField<int>('topLevelScore', int(1)),
    ValueField<int>('time', int(1000)),
    ValueField<int>('topScore', int(1)),
  ];

  // levelScore
  int get levelScore => box.get('levelScore') as int;
  set levelScore(int value) => box.put('levelScore', value);

  // topLevelScore
  int get topLevelScore => box.get('topLevelScore') as int;
  set topLevelScore(int value) => box.put('topLevelScore', value);

  // time
  int get time => box.get('time') as int;
  set time(int value) => box.put('time', value);

  // topScore
  int get topScore => box.get('topScore') as int;
  set topScore(int value) => box.put('topScore', value);
}
