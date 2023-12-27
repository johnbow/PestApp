import 'package:flutter/material.dart';
import 'package:pest/constants/strings.dart';

class DiceImageRepository {
  DiceImageRepository({required this.sides})
      : images = [
          for (int i = 0; i < sides; i++) AssetImage(AssetStrings.diceFaces[i])
        ];

  final int sides;

  final List<AssetImage> images;
}
