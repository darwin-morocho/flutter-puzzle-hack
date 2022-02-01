import 'package:flutter/material.dart';
import 'package:my_puzzle/src/domain/models/tile.dart';

class PuzzleTile extends StatelessWidget {
  final Tile tile;
  final double size;
  final VoidCallback onTap;
  const PuzzleTile({
    Key? key,
    required this.tile,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(
        milliseconds: 200,
      ),
      left: (tile.position.x - 1) * size,
      top: (tile.position.y - 1) * size,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.all(1),
          width: size - 2,
          height: size - 2,
          alignment: Alignment.center,
          child: Text(
            tile.value.toString(),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
