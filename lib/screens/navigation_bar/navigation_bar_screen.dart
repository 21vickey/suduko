import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_sizes.dart';

import '../../models/game_model.dart';
import '../../utils/game_colors.dart';
import '../../utils/game_text_styles.dart';
import '../main_screen/main_screen.dart';
import '../statistics_screen/statistics_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({
    super.key,
    this.pageIndex,
    this.savedGame,
  });

  final int? pageIndex;
  final GameModel? savedGame;

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = -1;

  void onTappedItem(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex =
        _selectedIndex == -1 ? (widget.pageIndex ?? 0) : _selectedIndex;

    List<Widget> screens = [
      MainScreen(savedGame: widget.savedGame),
      const StatisticsScreen(),
    ];
    return Scaffold(
      backgroundColor: GameColors.background,
      extendBody: true,
      body: screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 18, right: 18, bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.85),
              Colors.white.withOpacity(0.65),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BottomNavigationBar(
            elevation: 0,
            onTap: onTappedItem,
            items: navigationBarItems,
            currentIndex: _selectedIndex,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: GameColors.navigationBarItemActive,
            unselectedItemColor: GameColors.navigationBarItemPassive,
            selectedLabelStyle: GameTextStyles.navigationBarItemLabel
                .copyWith(fontSize: GameSizes.getWidth(0.034), fontWeight: FontWeight.bold),
            unselectedLabelStyle: GameTextStyles.navigationBarItemLabel.copyWith(
              fontSize: GameSizes.getWidth(0.032),
            ),
            showUnselectedLabels: true,
            iconSize: GameSizes.getWidth(0.09),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> get navigationBarItems => [
        BottomNavigationBarItem(
          label: "home".tr(),
          icon: AnimatedScale(
            scale: _selectedIndex == 0 ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Icon(Icons.home_rounded, size: GameSizes.getWidth(0.09)),
          ),
        ),
        BottomNavigationBarItem(
          label: "statistics".tr(),
          icon: AnimatedScale(
            scale: _selectedIndex == 1 ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Icon(Icons.bar_chart_rounded, size: GameSizes.getWidth(0.09)),
          ),
        ),
      ];
}
