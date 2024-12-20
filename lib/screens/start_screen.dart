import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hangman_game/app_assets.dart';
import 'package:hangman_game/screens/home_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainAccent,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
                margin: const EdgeInsets.only(top: 150),
                child: Text(
                  "HangMatch",
                  style: headerText,
                )),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(50),
              child: SvgPicture.asset(
                mainLogo,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 65),
            height: 60,
            width: 240,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                child: const Text(
                  "P L A Y",
                  style: TextStyle(
                    fontFamily: "Hoves",
                    fontSize: 25,
                    color: Color(0xFF1d1923),
                  ),
                )),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 65),
            child: Text(
              "Developed by anees-r",
              style: TextStyle(
                fontFamily: "Hoves",
                fontSize: 20,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
