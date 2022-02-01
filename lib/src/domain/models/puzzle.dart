import 'package:equatable/equatable.dart';
import 'package:my_puzzle/src/domain/models/position.dart';
import 'tile.dart';
import 'dart:math' as math;

class Puzzle extends Equatable {
  final List<Tile> tiles;

  final Position emptyPosition;

  const Puzzle._({
    required this.tiles,
    required this.emptyPosition,
  });

  /// a tile can be moved if is in the same
  /// row or in the same column of emptyPosition
  bool canMove(Position tilePosition) {
    if (tilePosition.x == emptyPosition.x || tilePosition.y == emptyPosition.y) {
      return true;
    }
    return false;
  }

  /// moves one or more tile vertically or horizontally
  Puzzle move(Tile tile) {
    final copy = [...tiles];
    // left or right
    if (tile.position.y == emptyPosition.y) {
      final row = tiles.where(
        (e) => e.position.y == emptyPosition.y,
      );

      // right
      if (tile.position.x < emptyPosition.x) {
        for (final e in row) {
          if (e.position.x < tile.position.x || e.position.x > emptyPosition.x) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x + 1,
              y: e.position.y,
            ),
          );
        }
      } else {
        // left
        for (final e in row) {
          if (e.position.x > tile.position.x || e.position.x < emptyPosition.x) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x - 1,
              y: e.position.y,
            ),
          );
        }
      }
    } else {
      // top or bottom
      final column = tiles.where(
        (e) => e.position.x == emptyPosition.x,
      );

      // bottom
      if (tile.position.y < emptyPosition.y) {
        for (final e in column) {
          if (e.position.y > emptyPosition.y || e.position.y < tile.position.y) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x,
              y: e.position.y + 1,
            ),
          );
        }
      } else {
        // top
        for (final e in column) {
          if (e.position.y < emptyPosition.y || e.position.y > tile.position.y) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x,
              y: e.position.y - 1,
            ),
          );
        }
      }
    }
    return Puzzle._(
      tiles: copy,
      emptyPosition: tile.position,
    );
  }

  /// creates a sorted puzzle
  factory Puzzle.create(int crossAxisCount) {
    int value = 1;
    final tiles = <Tile>[];

    final emptyPosition = Position(
      x: crossAxisCount,
      y: crossAxisCount,
    );
    for (int y = 1; y <= crossAxisCount; y++) {
      for (int x = 1; x <= crossAxisCount; x++) {
        final add = !(x == crossAxisCount && y == crossAxisCount);
        if (add) {
          final position = Position(x: x, y: y);
          final tile = Tile(
            value: value,
            position: position,
            correctPosition: position,
          );
          tiles.add(tile);
          value++;
        }
      }
    }

    return Puzzle._(
      tiles: tiles,
      emptyPosition: emptyPosition,
    );
  }

  /// shuffle the puzzle tiles
  Puzzle shuffle() {
    final values = List.generate(
      tiles.length,
      (index) => index + 1,
    );
    values.add(0);
    values.shuffle();

    // [1,2,3,4,5,6,7,8,9,0] => [1,3,4,0,5,7,8,9,2,6]

    if (_isSolvable(values)) {
      int x = 1, y = 1;
      late Position emptyPosition;
      final copy = [...tiles];
      final int crossAxisCount = math.sqrt(values.length).toInt();

      for (int i = 0; i < values.length; i++) {
        final value = values[i];
        final position = Position(x: x, y: y);
        if (value == 0) {
          emptyPosition = position;
        } else {
          copy[value - 1] = copy[value - 1].move(
            position,
          );
        }

        if ((i + 1) % crossAxisCount == 0) {
          y++;
          x = 1;
        } else {
          x++;
        }
      }

      return Puzzle._(
        tiles: copy,
        emptyPosition: emptyPosition,
      );
    } else {
      return shuffle();
    }
  }

  bool _isSolvable(List<int> values) {
    final n = math.sqrt(values.length);

    /// inversions
    int inversions = 0;
    int y = 1;
    int emptyPositionY = 1;

    for (int i = 0; i < values.length; i++) {
      if (i > 0 && i % n == 0) {
        y++;
      }

      final current = values[i];
      if (current == 1 || current == 0) {
        if (current == 0) {
          emptyPositionY = y;
        }
        continue;
      }
      for (int j = i + 1; j < values.length; j++) {
        final next = values[j];

        if (current > next && next != 0) {
          inversions++;
        }
      }
    }

    // is odd
    if (n % 2 != 0) {
      return inversions % 2 == 0;
    } else {
      // is even

      final yFromBottom = n - emptyPositionY + 1;

      if (yFromBottom % 2 == 0) {
        return inversions % 2 != 0;
      } else {
        return inversions % 2 == 0;
      }
    }
  }

  bool isSolved() {
    final crossAxisCount = math.sqrt(tiles.length + 1).toInt();
    if (emptyPosition.x == crossAxisCount && emptyPosition.y == crossAxisCount) {
      for (final tile in tiles) {
        if (tile.position != tile.correctPosition) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  @override
  List<Object?> get props => [
        tiles,
        emptyPosition,
      ];
}
