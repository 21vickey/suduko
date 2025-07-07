import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/enums.dart';
import '../../models/cell_model.dart';
import '../../models/game_model.dart';
import '../../utils/exports.dart';
import '../../widgets/app_bar_action_button.dart';
import '../../widgets/button/action_button/exports.dart';
import '../../widgets/game_info/exports.dart';
import '../../widgets/sudoku_board/exports.dart';
import 'game_screen_provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({required this.gameModel, super.key});
  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameScreenProvider>(
      create: (context) => GameScreenProvider(gameModel: gameModel),
      child: Consumer<GameScreenProvider>(builder: (context, provider, _) {
        return Scaffold(
          // Modern gradient background
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF232526), Color(0xFF1D2B64)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                GameAppBar(
                  onBackPressed: provider.onBackPressed,
                  onSettingsPressed: provider.onSettingsPressed,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: GameInfoCard(provider: provider),
                ),
                Expanded(
                  child: Center(
                    child: SudokuBoard(provider: provider),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: ActionButtons(provider: provider),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: NumberButtons(provider: provider),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// Modern info card with shadow and rounded corners
class GameInfoCard extends StatelessWidget {
  const GameInfoCard({required this.provider, super.key});
  final GameScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    final Difficulty difficulty = provider.difficulty;
    final int mistakes = provider.mistakes;
    final int score = provider.score;
    final int time = provider.time;
    final bool isPaused = provider.gamePaused;
    final Function() pauseGame = provider.pauseButtonOnTap;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GameInfoWidget(
                  value: difficulty.name.toLowerCase().tr(),
                  title: "difficulty".tr(),
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                GameInfoWidget(
                  value: '$mistakes/3',
                  title: "mistakes".tr(),
                ),
                GameInfoWidget(
                  value: '$score',
                  title: "score".tr(),
                ),
                GameInfoWidget(
                  value: time.toTimeString(),
                  title: "time".tr(),
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          PauseButton(isPaused: isPaused, onPressed: pauseGame),
        ],
      ),
    );
  }
}

// Modernized Action Button Row
class ActionButtons extends StatelessWidget {
  const ActionButtons({required this.provider, super.key});
  final GameScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ModernActionButton(
          title: "undo".tr(),
          icon: Icons.refresh,
          onTap: provider.undoOnTap,
        ),
        _ModernActionButton(
          title: "erase".tr(),
          icon: Icons.delete,
          onTap: provider.eraseOnTap,
        ),
        _ModernActionButton(
          title: "notes".tr(),
          icon: Icons.drive_file_rename_outline_outlined,
          onTap: provider.notesOnTap,
          highlight: provider.notesMode,
        ),
        _ModernActionButton(
          title: "hint".tr(),
          icon: Icons.lightbulb_outlined,
          onTap: provider.hintsOnTap,
          badge: provider.hints,
        ),
      ],
    );
  }
}

// Modern Action Button Widget
class _ModernActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool highlight;
  final int? badge;

  const _ModernActionButton({
    required this.title,
    required this.icon,
    required this.onTap,
    this.highlight = false,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: highlight ? Colors.amber.withOpacity(0.18) : Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(14),
          boxShadow: highlight
              ? [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Icon(icon, color: highlight ? Colors.amber : Colors.white, size: 26),
                if (badge != null && badge! > 0)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        badge.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: highlight ? Colors.amber : Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Modernized Number Buttons
class NumberButtons extends StatelessWidget {
  const NumberButtons({required this.provider, super.key});
  final GameScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(9, (index) {
        final bool showButton = provider.isNumberButtonNecessary(index + 1);
        final bool isSelected = provider.selectedCell.value == (index + 1);

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: showButton ? 1 : 0.3,
          child: GestureDetector(
            onTap: showButton ? () => provider.numberButtonOnTap(index + 1) : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              width: 38,
              decoration: BoxDecoration(
                color: isSelected ? Colors.amber.withOpacity(0.18) : Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: Colors.amber, width: 2)
                    : null,
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: provider.notesMode
                      ? GameTextStyles.noteButton.copyWith(fontSize: 22)
                      : GameTextStyles.numberButton.copyWith(fontSize: 22),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class SudokuBoard extends StatelessWidget {
  const SudokuBoard({required this.provider, super.key});

  final GameScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    double screenWidth = GameSizes.getWidth(1);
    double borderWidth = GameSizes.getWidth(0.006);
    double cellBorderWidth = GameSizes.getWidth(0.004);

    return Container(
      width: double.infinity,
      height: screenWidth - GameSizes.getWidth(0.06),
      margin: GameSizes.getHorizontalPadding(0.03),
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth),
      ),
      child: Stack(
        children: [
          VerticalLines(
              borderWidth: borderWidth, borderColor: GameColors.boardBorder),
          HorizontalLines(
              borderWidth: borderWidth, borderColor: GameColors.boardBorder),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: borderWidth,
              crossAxisSpacing: borderWidth,
            ),
            itemCount: 9,
            itemBuilder: (context, boxIndex) {
              return Stack(
                children: [
                  VerticalLines(
                    borderWidth: cellBorderWidth,
                    borderColor: GameColors.cellBorder,
                  ),
                  HorizontalLines(
                    borderWidth: cellBorderWidth,
                    borderColor: GameColors.cellBorder,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: cellBorderWidth,
                      crossAxisSpacing: cellBorderWidth,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, boxCellIndex) {
                      CellModel cell = provider.sudokuBoard
                          .getCellByBoxIndex(boxIndex, boxCellIndex);

                      return CellWidget(provider: provider, cell: cell);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class CellWidget extends StatelessWidget {
  const CellWidget({super.key, required this.provider, required this.cell});

  final GameScreenProvider provider;
  final CellModel cell;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => provider.cellOnTap(cell),
      child: Container(
        padding: GameSizes.getPadding(0.005),
        color: getCellColor(
          cell: cell,
          hideCells: provider.gamePaused,
          selectedCell: provider.selectedCell,
        ),
        child: getCellChild(cell),
      ),
    );
  }

  Widget getCellChild(CellModel cell) {
    if (provider.gamePaused) return const SizedBox.shrink();
    if (cell.hasValue) return CellValueText(cell: cell);

    return CellNotesGrid(cell: cell, selectedCell: provider.selectedCell);
  }
}

class CellNotesGrid extends StatelessWidget {
  const CellNotesGrid(
      {required this.cell, required this.selectedCell, super.key});

  final CellModel cell;
  final CellModel selectedCell;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 9,
        itemBuilder: (_, i) {
          final int number = i + 1;
          if (cell.notesContains(number)) {
            return FittedBox(
              child: Center(
                child: Text(
                  number.toString(),
                  style: number == selectedCell.value
                      ? GameTextStyles.highlightedNoteNumber
                          .copyWith(fontSize: GameSizes.getWidth(0.03))
                      : GameTextStyles.noteNumber
                          .copyWith(fontSize: GameSizes.getWidth(0.03)),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }
}

class CellValueText extends StatelessWidget {
  const CellValueText({required this.cell, super.key});

  final CellModel cell;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Center(
        child: Text(
          cell.print(),
          style: getStyle(cell)?.copyWith(fontSize: GameSizes.getWidth(0.1)),
        ),
      ),
    );
  }
}

class GameInfo extends StatelessWidget {
  const GameInfo({required this.provider, super.key});

  final GameScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    final Difficulty difficulty = provider.difficulty;
    final int mistakes = provider.mistakes;
    final int score = provider.score;
    final int time = provider.time;

    final bool isPaused = provider.gamePaused;
    final Function() pauseGame = provider.pauseButtonOnTap;

    return Padding(
      padding: GameSizes.getPadding(0.025),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GameInfoWidget(
                  value: difficulty.name.toLowerCase().tr(),
                  title: "difficulty".tr(),
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                GameInfoWidget(
                  value: '$mistakes/3',
                  title: "mistakes".tr(),
                ),
                GameInfoWidget(
                  value: '$score',
                  title: "score".tr(),
                ),
                GameInfoWidget(
                  value: time.toTimeString(),
                  title: "time".tr(),
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ],
            ),
          ),
          SizedBox(width: GameSizes.getWidth(0.03)),
          PauseButton(isPaused: isPaused, onPressed: pauseGame),
        ],
      ),
    );
  }
}

class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GameAppBar({
    required this.onBackPressed,
    required this.onSettingsPressed,
    super.key,
  });

  final Function() onBackPressed;
  final Function() onSettingsPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: GameColors.appBarBackground,
      centerTitle: true,
      elevation: 0,
      toolbarHeight: GameSizes.getWidth(0.1),
      title: Text(GameStrings.sudoku,
          style: GameTextStyles.appBarTitle.copyWith(
            fontSize: GameSizes.getWidth(0.06),
          )),
      leadingWidth: GameSizes.getWidth(0.1),
      leading: AppBarActionButton(
        icon: Icons.arrow_back_ios_new,
        onPressed: onBackPressed,
        iconSize: GameSizes.getWidth(0.06),
      ),
      actions: [
        // AppBarActionButton(
        //   icon: Icons.palette_outlined,
        //   onPressed: () {},
        // ),
        AppBarActionButton(
          icon: Icons.settings_outlined,
          onPressed: onSettingsPressed,
        ),
        SizedBox(width: GameSizes.getWidth(0.02)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(GameSizes.getWidth(0.1));
}
