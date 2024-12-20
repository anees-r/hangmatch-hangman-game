import 'package:flutter/material.dart';
import 'package:hangman_game/app_assets.dart';

Widget hiddenWord(String char, bool visible) {
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(10),
    height: 60,
    width: 40,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: visible ? Colors.white : mainAccent,
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(10)),
    child: Visibility(
      visible: visible,
      child: Text(
        char,
        style: TextStyle(
          fontFamily: "Hoves",
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: mainAccent,
        ),
      ),
    ),
  );
}
