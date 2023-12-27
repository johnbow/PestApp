import 'package:flutter/material.dart';

final roundButtonStyle = ElevatedButton.styleFrom(
    padding: EdgeInsets.all(60),
    elevation: 4,
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    shape: const CircleBorder(side: BorderSide(color: Colors.white)),
    textStyle: const TextStyle(fontSize: 22));
