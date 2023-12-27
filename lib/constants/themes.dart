import 'package:flutter/material.dart';

final roundButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(60),
    elevation: 8,
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    shape: const CircleBorder(side: BorderSide(color: Colors.white)),
    textStyle: const TextStyle(fontSize: 22));
