import 'package:flutter/material.dart';

void main() {
  runApp(Align(
      alignment: FractionalOffset(0.3, 0.3),
      child: Text(
        'Hello Flutter',
        textDirection: TextDirection.rtl, // текст слева направо
        style: TextStyle(
          fontSize: 25,
          fontFamily: "Ubuntu Mono",
          color: Color.fromARGB(0xFF, 0x42, 0xA5, 0xF5),
        ),
      )));
}
