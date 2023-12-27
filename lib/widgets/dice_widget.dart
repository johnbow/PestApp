import 'package:flutter/material.dart';
import 'package:pest/constants/strings.dart';

class DiceWidget extends StatelessWidget {
  const DiceWidget({super.key, required this.side, this.size = 200});

  final double size;
  final int side;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 4,
        child: Image(
          image: AssetImage(AssetStrings.diceFaces[side - 1]),
          width: size,
          height: size,
        ),
      ),
    );
  }
}
