import 'package:flutter/material.dart';

final colorScheme =
    ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark);

final roundButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(70),
    elevation: 8,
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    shape: const CircleBorder(side: BorderSide(color: Colors.white)),
    textStyle: const TextStyle(fontSize: 22));
