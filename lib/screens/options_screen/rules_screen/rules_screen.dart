// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sudoku/utils/game_colors.dart';
// import 'package:flutter_sudoku/utils/game_sizes.dart';
// import 'package:flutter_sudoku/utils/game_text_styles.dart';

// class RulesScreen extends StatelessWidget {
//   const RulesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: GameColors.optionsBackground,
//       appBar: AppBar(
//         elevation: 0.5,
//         centerTitle: true,
//         backgroundColor: GameColors.appBarBackground,
//         title: Text(
//           "rules".tr(),
//           style: GameTextStyles.optionsScreenAppBarTitle
//               .copyWith(fontSize: GameSizes.getWidth(0.045)),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: GameSizes.getSymmetricPadding(0.04, 0.02),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               "sudokuRules".tr(),
//               style: TextStyle(
//                 fontWeight: FontWeight.w800,
//                 fontSize: GameSizes.getWidth(0.05),
//               ),
//             ),
//             SizedBox(height: GameSizes.getWidth(0.025)),
//             Text(
//               "sudokuRulesTexts".tr(),
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: GameSizes.getWidth(0.038),
//               ),
//             ),
//             SizedBox(height: GameSizes.getWidth(0.025)),
//             Icon(
//               Icons.circle,
//               size: GameSizes.getWidth(0.025),
//               color: Colors.black,
//             ),
//             SizedBox(height: GameSizes.getWidth(0.025)),
//             Text(
//               "tipsOnSolvingSudokuPuzzles".tr(),
//               style: TextStyle(
//                 fontWeight: FontWeight.w800,
//                 fontSize: GameSizes.getWidth(0.05),
//               ),
//             ),
//             SizedBox(height: GameSizes.getWidth(0.025)),
//             Text(
//               "tipsOnSolvingSudokuPuzzlesTexts".tr(),
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: GameSizes.getWidth(0.038),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';
import 'package:flutter_sudoku/utils/game_sizes.dart';
import 'package:flutter_sudoku/utils/game_text_styles.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "rules".tr(),
          style: GameTextStyles.optionsScreenAppBarTitle.copyWith(
            fontSize: GameSizes.getWidth(0.048),
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF141E30), Color(0xFF243B55)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: GameSizes.getSymmetricPadding(0.05, 0.07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionCard(
                title: "sudokuRules".tr(),
                text: "sudokuRulesTexts".tr(),
                icon: Icons.grid_4x4_rounded,
                iconColor: Colors.blueAccent,
              ),
              SizedBox(height: GameSizes.getHeight(0.04)),
              _buildSectionCard(
                title: "tipsOnSolvingSudokuPuzzles".tr(),
                text: "tipsOnSolvingSudokuPuzzlesTexts".tr(),
                icon: Icons.lightbulb_outline,
                iconColor: Colors.amberAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String text,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(GameSizes.getWidth(0.05)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.white10, Colors.white12],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 8),
          )
        ],
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: GameSizes.getWidth(0.06)),
              SizedBox(width: GameSizes.getWidth(0.03)),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: GameSizes.getWidth(0.05),
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: GameSizes.getHeight(0.015)),
          Text(
            text,
            style: TextStyle(
              fontSize: GameSizes.getWidth(0.038),
              fontWeight: FontWeight.w500,
              height: 1.6,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
