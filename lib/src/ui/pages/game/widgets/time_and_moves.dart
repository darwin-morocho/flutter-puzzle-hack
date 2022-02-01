import 'package:flutter/material.dart';
import 'package:my_puzzle/src/ui/pages/game/controller/game_controller.dart';
import 'package:my_puzzle/src/ui/utils/time_parser.dart';
import 'package:provider/provider.dart';

class TimeAndMoves extends StatelessWidget {
  const TimeAndMoves({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = Provider.of<GameController>(context, listen: false).time;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ValueListenableBuilder<int>(
          valueListenable: time,
          builder: (_, time, icon) {
            return Row(
              children: [
                icon!,
                Text(
                  parseTime(time),
                ),
              ],
            );
          },
          child: const Icon(
            Icons.watch,
          ),
        ),
        Selector<GameController, int>(
          builder: (_, moves, __) {
            return Text("Moves: $moves");
          },
          selector: (_, controller) => controller.state.moves,
        ),
      ],
    );
  }
}
