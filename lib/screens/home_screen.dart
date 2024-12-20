import 'dart:math';
import 'dart:ui';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hangman_game/app_assets.dart';
import 'package:hangman_game/components/hidden_word.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String characters = "abcdefghijklmnopqrstuvwxyz?".toUpperCase();
  String word = (List.from(nouns)..shuffle())
      .firstWhere((word) => word.length <= 6)
      .toUpperCase();
  List<String> selectedCharacter = [];
  String graphic = stageZero;
  int tries = 6;

  void _updateGraphic() {
    setState(() {
      if (tries == 0) {
        graphic = stageSix;
      }
      if (tries == 1) {
        graphic = stageFive;
      }
      if (tries == 2) {
        graphic = stageFour;
      }
      if (tries == 3) {
        graphic = stageThree;
      }
      if (tries == 4) {
        graphic = stageTwo;
      }
      if (tries == 5) {
        graphic = stageOne;
      }
      if (tries == 6) {
        graphic = stageZero;
      }
    });
  }

  void _checkLetter(String char) {
    setState(() {
      if (char == "?") {
        _checkLetter(hint());
        selectedCharacter.add(char);
      } else {
        selectedCharacter.add(char);
        if (!word.split("").contains(char.toUpperCase())) {
          tries--;
          _updateGraphic();
        }
        _checkStatus(char);
      }
    });
  }

  void _checkStatus(String char) {
    if (tries == 0) {
      _showLostBox();
    } else if (word
        .split('')
        .every((char) => selectedCharacter.contains(char))) {
      _showWonBox();
    }
  }

  void _showLostBox() {
    showDialog(
        barrierDismissible: false,
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              shadowColor: Colors.black,
              backgroundColor: mainAccent,
              title: Text(
                "LOST!",
                style: headerText,
                textAlign: TextAlign.center,
              ),
              content: Text(
                "The word was: $word",
                style: playerText,
                textAlign: TextAlign.center,
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _clearGame();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Change button color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(100), // Rounded corners
                      ),
                    ),
                    child: Text(
                      "P L A Y   A G A I N",
                      style: buttonText,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  void _showWonBox() {
    showDialog(
        barrierDismissible: false,
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              shadowColor: Colors.black,
              backgroundColor: mainAccent,
              title: Text(
                "GUESSED!",
                style: headerText,
                textAlign: TextAlign.center,
              ),
              content: Text(
                "The word was: $word",
                style: playerText,
                textAlign: TextAlign.center,
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _clearGame();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Change button color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(100), // Rounded corners
                      ),
                    ),
                    child: Text(
                      "P L A Y   A G A I N",
                      style: buttonText,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  void _clearGame() {
    setState(() {
      selectedCharacter = [];
      tries = 6;
      graphic = stageZero;
      word = (List.from(nouns)..shuffle())
          .firstWhere((word) => word.length <= 6)
          .toUpperCase();
    });
  }

  String hint() {
    // Generate a random index within the length of the word
    int randomIndex = Random().nextInt(word.length);

    // Get the letter at the random index
    String randomLetter = word[randomIndex];

    // return the random letter
    return randomLetter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainAccent,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: mainAccent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_rounded)),
        title: Text(
          "HangMatch",
          style: headerText,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.favorite,
                  size: 35, // Adjust the size of the icon
                  color: Colors.white,
                ),
                Text(
                  tries.toString(), // The text to display inside the icon
                  style: TextStyle(
                    color: mainAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                graphic,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: word
                            .split("")
                            .map((e) => hiddenWord(
                                e, selectedCharacter.contains(e.toUpperCase())))
                            .toList()),
                  )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 9,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          children: characters.split("").map((e) {
                            return Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap:
                                    selectedCharacter.contains(e.toUpperCase())
                                        ? null
                                        : () => _checkLetter(e),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: selectedCharacter
                                              .contains(e.toUpperCase())
                                          ? Colors.white.withOpacity(0.3)
                                          : e == "?"
                                              ? const Color.fromARGB(
                                                  255, 137, 69, 255)
                                              : Colors.white.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    e,
                                    style: TextStyle(
                                      fontFamily: "Hoves",
                                      fontSize: 16,
                                      color:
                                          e == "?" ? Colors.white : mainAccent,
                                    ),
                                  )),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
