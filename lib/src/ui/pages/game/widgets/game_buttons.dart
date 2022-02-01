import 'package:flutter/material.dart';
import 'package:my_puzzle/src/ui/pages/game/controller/game_controller.dart';
import 'package:my_puzzle/src/ui/pages/game/controller/game_state.dart';
import 'package:provider/provider.dart';

class GameButtons extends StatelessWidget {
  const GameButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final state = controller.state;
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
            onPressed: controller.shuffle,
            icon: const Icon(
              Icons.replay_rounded,
            ),
            label: Text(
              state.status == GameStatus.created ? "START" : "RESET",
            ),
          ),
          const SizedBox(width: 20),
          DropdownButton<int>(
            items: [3, 4, 5, 6]
                .map(
                  (e) => DropdownMenuItem(
                    child: Text("${e}x$e"),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (crossAxisCount) {
              if (crossAxisCount != null && crossAxisCount != state.crossAxisCount) {
                controller.changeGrid(crossAxisCount);
              }
            },
            value: state.crossAxisCount,
          ),
        ],
      ),
    );
  }
}
