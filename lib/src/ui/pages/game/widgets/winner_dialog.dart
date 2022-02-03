import 'package:flutter/material.dart';
import 'package:my_puzzle/generated/l10n.dart';
import 'package:my_puzzle/src/ui/global/widgets/up_to_down.dart';
import 'package:my_puzzle/src/ui/icons/puzzle_icons.dart';
import 'package:my_puzzle/src/ui/utils/colors.dart';
import 'package:my_puzzle/src/ui/utils/dark_mode_extension.dart';
import 'package:my_puzzle/src/ui/utils/time_parser.dart';

Future<void> showWinnerDialog(
  BuildContext context, {
  required int moves,
  required int time,
}) {
  return showDialog(
    context: context,
    builder: (_) => WinnerDialog(
      moves: moves,
      time: time,
    ),
  );
}

class WinnerDialog extends StatelessWidget {
  final int moves;
  final int time;
  const WinnerDialog({
    Key? key,
    required this.moves,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final texts = S.current;
    final isDarkMode = context.isDarkMode;
    return Center(
      child: UpToDown(
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: isDarkMode ? darkColor : lightColor,
          child: SizedBox(
            width: 340,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Transform.scale(
                    scale: 1.5,
                    child: Image.asset(
                      'assets/images/dash.png',
                      width: 200,
                    ),
                  ),
                ),
                Text(
                  texts.great_job,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    texts.completed,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            PuzzleIcons.watch,
                          ),
                          Text(
                            parseTime(time),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.multiple_stop_rounded,
                          ),
                          Text(
                            "${texts.movements} $moves",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 0.6,
                  color: isDarkMode ? Colors.white24 : Colors.black12,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      texts.ok,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
