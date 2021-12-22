import 'package:flutter/material.dart';

Widget borderButton(
    {width,
    height,
    Color color = Colors.white,
    String text = '',
    double fontSize = 20,
    IconData? icon,
    required Function() onPressed}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        fixedSize:
            (width != null && height != null) ? Size(width, height) : null,
        primary: color,
        side: const BorderSide(color: Colors.brown, width: 6),
      ),
      onPressed: onPressed,
      child: (icon == null)
          ? Text(text,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ))
          : Icon(
              icon,
              size: 30,
            ));
}
