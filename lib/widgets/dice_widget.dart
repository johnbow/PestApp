import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/repositories/image_repository.dart';

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
          image: context.read<DiceImageRepository>().images[side - 1],
          width: size,
          height: size,
        ),
      ),
    );
  }
}
