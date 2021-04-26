part of 'game_state.dart';

class $BoxGameState extends BoxWrapper {
  $BoxGameState() : super('game_state');

  // @override
  // List<ValueField> fields = [
  //   IntField('level_score', 1),
  //   IntField('top_level_score', 1),
  //   IntField('time', 1000),
  //   IntField('top_score', 1),
  // ];

  // time
  int get time => box.get('time') as int;

  set time(int value) => box.put('time', value);

  // level score
  int get levelScore => box.get('level_score') as int;

  set levelScore(int value) => box.put('level_score', value);

  // max level score
  int get topLevelScore => box.get('top_level_score') as int;

  set topLevelScore(int value) => box.put('top_level_score', value);

  // max score
  int get topScore => box.get('top_score') as int;

  set topScore(int value) => box.put('top_score', value);
}
