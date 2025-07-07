// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// import '../../constant/enums.dart';
// import '../../constant/game_constants.dart';
// import '../../models/option_button_model.dart';
// import '../../utils/game_colors.dart';
// import '../../utils/game_routes.dart';
// import '../../utils/game_sizes.dart';
// import '../widget_divider.dart';

// class ModalBottomSheets {
//   static Future<dynamic> chooseTimeInterval(TimeInterval timeInterval) async {
//     List<TimeInterval> options = List.from(GameSettings.getTimeIntervals);
//     options.add(timeInterval);

//     return await _showOptions(
//         options: List.generate(options.length, (index) {
//       TimeInterval intervalOption = options[index];
//       bool last = index == options.length - 1;
//       final bool isSelected = intervalOption.name == timeInterval.name && !last;
//       final String title =
//           last ? "cancel".tr() : intervalOption.name.toLowerCase().tr();

//       return OptionButtonModel(
//           onTap: () => intervalOption, selected: isSelected, title: title);
//     }));
//   }

//   static Future<dynamic> chooseDifficulty(
//       {Difficulty? restartDifficulty}) async {
//     List<Difficulty> options = List.from(GameSettings.getDifficulties);
//     final bool restartButton = restartDifficulty != null;

//     if (restartButton) options.add(restartDifficulty);

//     return await _showOptions(
//         options: List.generate(options.length, (index) {
//       final String title = index == options.length - 1 && restartButton
//           ? "restart".tr()
//           : options[index].name.toLowerCase().tr();

//       return OptionButtonModel(title: title, onTap: () => options[index]);
//     }));
//   }

//   static Future<dynamic> _showOptions({
//     required List<OptionButtonModel> options,
//   }) {
//     const double radius = 28;
//     final double leadingWidth = GameSizes.getWidth(0.15);

//     final bool leading = options.any((element) => element.selected);

//     return showModalBottomSheet(
//       context: GameRoutes.navigatorKey.currentContext!,
//       backgroundColor: Colors.transparent,
//       enableDrag: false,
//       builder: (context) {
//         return Container(
//           margin: GameSizes.getPadding(0.02),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: GameSizes.getRadius(radius),
//           ),
//           child: WidgetDivider(
//             leftPadding: leading ? leadingWidth - 3 : 0,
//             children: List.generate(
//               options.length,
//               (index) {
//                 final OptionButtonModel optionButton = options[index];

//                 BorderRadius borderRadius = BorderRadius.zero;
//                 if (index == 0) {
//                   borderRadius = const BorderRadius.only(
//                     topLeft: Radius.circular(radius),
//                     topRight: Radius.circular(radius),
//                   );
//                 } else if (index == options.length - 1) {
//                   borderRadius = const BorderRadius.only(
//                     bottomLeft: Radius.circular(radius),
//                     bottomRight: Radius.circular(radius),
//                   );
//                 }

//                 return Material(
//                   borderRadius: GameSizes.getRadius(28),
//                   child: InkWell(
//                     highlightColor: GameColors.whiteButtonForeground,
//                     onTap: () {
//                       Navigator.pop(context, optionButton.onTap());
//                     },
//                     borderRadius: borderRadius,
//                     child: Container(
//                       width: double.infinity,
//                       padding: GameSizes.getVerticalPadding(0.02),
//                       child: Row(
//                         children: [
//                           if (leading) ...[
//                             SizedBox(
//                               width: leadingWidth,
//                               child: Visibility(
//                                 visible: optionButton.selected,
//                                 child: Center(
//                                   child: Icon(
//                                     Icons.done,
//                                     color: GameColors.roundedButton,
//                                     size: GameSizes.getWidth(0.06),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                           Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: leading
//                                   ? CrossAxisAlignment.start
//                                   : CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   optionButton.title,
//                                   style: TextStyle(
//                                     color: GameColors.roundedButton,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: GameSizes.getWidth(0.045),
//                                   ),
//                                 ),
//                                 if (optionButton.subTitle != null) ...[
//                                   Text(
//                                     optionButton.title,
//                                     style: TextStyle(
//                                       color: GameColors.roundedButton,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: GameSizes.getWidth(0.03),
//                                     ),
//                                   ),
//                                 ],
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constant/enums.dart';
import '../../constant/game_constants.dart';
import '../../models/option_button_model.dart';
import '../../utils/game_colors.dart';
import '../../utils/game_routes.dart';
import '../../utils/game_sizes.dart';
import '../widget_divider.dart';

class ModalBottomSheets {
  static Future<dynamic> chooseTimeInterval(TimeInterval timeInterval) async {
    List<TimeInterval> options = List.from(GameSettings.getTimeIntervals);
    options.add(timeInterval);

    return await _showOptions(
      options: List.generate(options.length, (index) {
        TimeInterval intervalOption = options[index];
        bool last = index == options.length - 1;
        final bool isSelected = intervalOption.name == timeInterval.name && !last;
        final String title =
            last ? "cancel".tr() : intervalOption.name.toLowerCase().tr();

        return OptionButtonModel(
          onTap: () => intervalOption,
          selected: isSelected,
          title: title,
        );
      }),
    );
  }

  static Future<dynamic> chooseDifficulty({Difficulty? restartDifficulty}) async {
    List<Difficulty> options = List.from(GameSettings.getDifficulties);
    final bool restartButton = restartDifficulty != null;

    if (restartButton) options.add(restartDifficulty);

    return await _showOptions(
      options: List.generate(options.length, (index) {
        final String title = index == options.length - 1 && restartButton
            ? "restart".tr()
            : options[index].name.toLowerCase().tr();

        return OptionButtonModel(
          title: title,
          onTap: () => options[index],
        );
      }),
    );
  }

  static Future<dynamic> _showOptions({
    required List<OptionButtonModel> options,
  }) {
    const double radius = 28;
    final double leadingWidth = GameSizes.getWidth(0.15);
    final bool leading = options.any((element) => element.selected);

    return showModalBottomSheet(
      context: GameRoutes.navigatorKey.currentContext!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          margin: GameSizes.getPadding(0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: const LinearGradient(
              colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: WidgetDivider(
            leftPadding: leading ? leadingWidth - 3 : 0,
            children: List.generate(options.length, (index) {
              final OptionButtonModel optionButton = options[index];

              BorderRadius borderRadius = BorderRadius.zero;
              if (index == 0) {
                borderRadius = const BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius),
                );
              } else if (index == options.length - 1) {
                borderRadius = const BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                );
              }

              return Material(
                color: Colors.white.withOpacity(0.05),
                borderRadius: borderRadius,
                child: InkWell(
                  splashColor: Colors.cyan.withOpacity(0.3),
                  highlightColor: Colors.transparent,
                  borderRadius: borderRadius,
                  onTap: () {
                    Navigator.pop(context, optionButton.onTap());
                  },
                  child: Container(
                    padding: GameSizes.getVerticalPadding(0.03),
                    child: Row(
                      children: [
                        if (leading) ...[
                          SizedBox(
                            width: leadingWidth,
                            child: Visibility(
                              visible: optionButton.selected,
                              child: Center(
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.cyanAccent,
                                  size: GameSizes.getWidth(0.06),
                                ),
                              ),
                            ),
                          ),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: leading
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.center,
                            children: [
                              Text(
                                optionButton.title,
                                style: TextStyle(
                                  fontSize: GameSizes.getWidth(0.045),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              if (optionButton.subTitle != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  optionButton.subTitle!,
                                  style: TextStyle(
                                    fontSize: GameSizes.getWidth(0.032),
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
