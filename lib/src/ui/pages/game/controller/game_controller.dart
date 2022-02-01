import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:my_puzzle/src/domain/models/puzzle.dart';
import 'package:my_puzzle/src/domain/models/tile.dart';
import 'package:my_puzzle/src/ui/pages/game/controller/game_state.dart';

class GameController extends ChangeNotifier {
  GameState _state = GameState(
    crossAxisCount: 3,
    puzzle: Puzzle.create(3),
    solved: false,
    moves: 0,
    status: GameStatus.created,
  );

  final ValueNotifier<int> time = ValueNotifier(0);

  final StreamController<void> _streamController = StreamController.broadcast();

  Stream<void> get onFinish => _streamController.stream;

  Timer? _timer;

  GameState get state => _state;

  Puzzle get puzzle => _state.puzzle;

  void onTileTapped(Tile tile) {
    final canMove = puzzle.canMove(tile.position);
    if (canMove) {
      final newPuzzle = puzzle.move(tile);
      final solved = newPuzzle.isSolved();
      _state = state.copyWith(
        puzzle: newPuzzle,
        moves: state.moves + 1,
        status: solved ? GameStatus.solved : state.status,
      );
      notifyListeners();
      if (solved) {
        _timer?.cancel();
        _streamController.sink.add(null);
      }
    }
  }

  void shuffle() {
    if (_timer != null) {
      time.value = 0;
      _timer!.cancel();
    }
    _state = state.copyWith(
      puzzle: puzzle.shuffle(),
      status: GameStatus.playing,
      moves: 0,
    );
    notifyListeners();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        time.value++;
      },
    );
  }

  void changeGrid(int crossAxisCount) {
    _timer?.cancel();
    time.value = 0;
    final newState = GameState(
      crossAxisCount: crossAxisCount,
      puzzle: Puzzle.create(crossAxisCount),
      solved: false,
      moves: 0,
      status: GameStatus.created,
    );
    _state = newState;
    notifyListeners();
  }

  @override
  void dispose() {
    _streamController.close();
    _timer?.cancel();
    super.dispose();
  }
}
