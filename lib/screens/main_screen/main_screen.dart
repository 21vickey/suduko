import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/game_model.dart';
import '../../utils/game_colors.dart';
import '../../utils/game_routes.dart';
import '../../utils/game_sizes.dart';
import '../../utils/game_text_styles.dart';
import '../../widgets/app_bar_action_button.dart';
import '../../widgets/button/rounded_button/rounded_button.dart';
import 'main_screen_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({this.savedGame, super.key});

  final GameModel? savedGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a vibrant gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D5BFF), Color(0xFFA9F1DF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: ChangeNotifierProvider<MainScreenProvider>(
            create: (context) => MainScreenProvider(savedGame: savedGame),
            child: Consumer<MainScreenProvider>(
              builder: (context, provider, _) {
                return Column(
                  children: [
                    // Custom gradient AppBar
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: GameSizes.getWidth(0.045),
                        horizontal: GameSizes.getWidth(0.04),
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF4E54C8), Color(0xFF8F94FB)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "GridHero Sudoku",
                              style: GameTextStyles.mainScreenTitle.copyWith(
                                fontSize: GameSizes.getWidth(0.07),
                                color: const Color.fromARGB(255, 195, 169, 240),
                                fontWeight: FontWeight.bold,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          AppBarActionButton(
                            onPressed: () => GameRoutes.goTo(
                              GameRoutes.optionsScreen,
                              enableBack: true,
                            ),
                            icon: Icons.settings_outlined,
                            iconSize: GameSizes.getWidth(0.08),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: GameSizes.getSymmetricPadding(0.04, 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Playful welcome
                            const SizedBox(height: 20),
                            const AnimatedAppLogo(),
                            const SizedBox(height: 16),
                            Text(
                              "👋 Welcome to Sudoku Master!",
                              style: GameTextStyles.mainScreenTitle.copyWith(
                                fontSize: GameSizes.getWidth(0.07),
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            GameTitle(
                              title: "Ready for your next puzzle?".tr(),
                            ),
                            Container(
                              height: GameSizes.getHeight(0.25),
                              padding: GameSizes.getHorizontalPadding(0.05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Visibility(
                                    visible: provider.isThereASavedGame,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: GameSizes.getHeight(0.025),
                                      ),
                                      child: RoundedButton(
                                        buttonText: "Continue Game".tr(),
                                        subText: provider.continueGameButtonText,
                                        subIcon: Icons.play_arrow,
                                        onPressed: provider.continueGame,
                                        textSize: GameSizes.getHeight(0.022),
                                        color: const Color(0xFF6D5BFF),
                                        textColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  RoundedButton(
                                    buttonText: "Start New Game".tr(),
                                    whiteButton: false,
                                    elevation: 8,
                                    color: const Color(0xFF48C6EF),
                                    textColor: Colors.white,
                                    onPressed: provider.newGame,
                                    textSize: GameSizes.getHeight(0.023),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Modern title widget
class GameTitle extends StatelessWidget {
  const GameTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: GameSizes.getHorizontalPadding(0.05),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GameTextStyles.mainScreenTitle.copyWith(
            fontSize: GameSizes.getWidth(0.055),
            color: Colors.deepPurpleAccent,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}

// Custom animated logo with a twist
class AnimatedAppLogo extends StatefulWidget {
  const AnimatedAppLogo({super.key});
  @override
  State<AnimatedAppLogo> createState() => _AnimatedAppLogoState();
}

class _AnimatedAppLogoState extends State<AnimatedAppLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.95, end: 1.05).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: Container(
        width: 92,
        height: 92,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurpleAccent.withOpacity(0.3),
              blurRadius: 24,
            ),
          ],
        ),
        child: const Center(
          child: Icon(Icons.extension, color: Color(0xFF6D5BFF), size: 64),
        ),
      ),
    );
  }
}