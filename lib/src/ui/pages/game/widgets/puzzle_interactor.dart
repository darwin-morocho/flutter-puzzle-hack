import 'package:flutter/material.dart';
import 'package:my_puzzle/src/ui/pages/game/controller/game_controller.dart';
import 'package:my_puzzle/src/ui/pages/game/controller/game_state.dart';
import 'package:my_puzzle/src/ui/pages/game/widgets/puzzle_tile.dart';
import 'package:provider/provider.dart';

class PuzzleInteractor extends StatelessWidget {
  const PuzzleInteractor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final controller = context.watch<GameController>();
          final state = controller.state;
          final tileSize = constraints.maxWidth / state.crossAxisCount;

          return AbsorbPointer(
            absorbing: state.status != GameStatus.playing,
            child: Stack(
              children: state.puzzle.tiles
                  .map(
                    (e) => PuzzleTile(
                      tile: e,
                      size: tileSize,
                      onTap: () => controller.onTileTapped(e),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
