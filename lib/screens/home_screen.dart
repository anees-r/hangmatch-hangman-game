import 'package:flutter/material.dart';
import 'package:hangman_game/app_assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        actions: const [],
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                stageSix,
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 1,
              child: GridView.builder(
                  itemCount: 27,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 9),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(child: Text(index.toString())),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
