import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';
import 'package:flutter_sudoku/utils/game_sizes.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.icon, this.onPressed, this.iconColor, this.backgroundColor});

  final IconData icon;
  final Function()? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor ?? GameColors.appBarActions,
      radius: GameSizes.getWidth(0.06),
      child: IconButton(
        onPressed: onPressed,
        iconSize: GameSizes.getWidth(0.07),
        icon: Icon(icon, color: iconColor ?? Colors.white),
      ),
    );
  }
}
