import 'package:equatable/equatable.dart';
import 'package:my_puzzle/src/domain/models/puzzle.dart';

enum GameStatus {
  created,
  playing,
  solved,
}

class GameState extends Equatable {
  final int crossAxisCount;
  final Puzzle puzzle;
  final bool solved;
  final int moves;
  final GameStatus status;

  const GameState({
    required this.crossAxisCount,
    required this.puzzle,
    required this.solved,
    required this.moves,
    required this.status,
  });

  GameState copyWith({
    int? crossAxisCount,
    int? moves,
    Puzzle? puzzle,
    bool? solved,
    GameStatus? status,
  }) {
    return GameState(
      status: status ?? this.status,
      moves: moves ?? this.moves,
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      puzzle: puzzle ?? this.puzzle,
      solved: solved ?? this.solved,
    );
  }

  @override
  List<Object?> get props => [
        moves,
        crossAxisCount,
        puzzle,
        solved,
        status,
      ];
}
