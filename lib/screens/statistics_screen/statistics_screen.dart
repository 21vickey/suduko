import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/enums.dart';
import '../../constant/game_constants.dart';
import '../../models/stat_group_model.dart';
import '../../models/stat_model.dart';
import '../../utils/game_colors.dart';
import '../../utils/game_sizes.dart';
import '../../utils/game_strings.dart';
import '../../utils/game_text_styles.dart';
import '../../widgets/app_bar_action_button.dart';
import 'statistics_screen_provider.dart';

// Gameified, modern statistics screen
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Difficulty> difficulties = GameSettings.getDifficulties;

    return DefaultTabController(
      length: difficulties.length,
      child: ChangeNotifierProvider<StatisticsScreenProvider>(
        create: (context) => StatisticsScreenProvider(),
        child: Consumer<StatisticsScreenProvider>(
          builder: (context, provider, _) {
            return Scaffold(
              // Vibrant gradient background
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF232526), Color(0xFF1D2B64)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      // Gamified header with trophy and badges
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 18.0,
                          horizontal: 16.0,
                        ),
                        child: Row(
                          children: [
                            _Trophy(),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Statistics".tr(),
                                    style: GameTextStyles.mainScreenTitle
                                        .copyWith(
                                          fontSize: 28,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      _Badge(
                                        icon: Icons.local_fire_department,
                                        color: Colors.orange,
                                        label: "Streak",
                                      ),
                                      const SizedBox(width: 10),
                                      _Badge(
                                        icon: Icons.emoji_events,
                                        color: Colors.amber,
                                        label: "Achievements",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // AppBarActionButton(
                            //   onPressed: () => Navigator.pop(context),
                            //   icon: Icons.close,
                            //   iconSize: 30,
                            //   color: Colors.white,
                            // ),
                          ],
                        ),
                      ),

                      // Tab bar for difficulties
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.only(left: 9),
                        child: TabBar(
                          tabAlignment: TabAlignment.start,
                          indicatorColor: Colors.amber,
                          isScrollable: true,
                          // indicator: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(24),
                          //   color: Colors.white.withOpacity(0.16),
                          // ),
                          labelColor: Colors.amber,
                          dividerColor: Colors.transparent,
                          unselectedLabelColor: Colors.white70,
                          tabs:
                              difficulties
                                  .map(
                                    (d) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16.0,
                                        horizontal: 6,
                                      ),
                                      child: Text(
                                        d.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,

                                          // color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child:
                            provider.loading
                                ? const Center(
                                  child: CupertinoActivityIndicator(
                                    color: Colors.amber,
                                  ),
                                )
                                : TabBarView(
                                  children: List.generate(
                                    difficulties.length,
                                    (index) => Statistics(
                                      provider: provider,
                                      statGroupModel: provider.getStatGroup(
                                        difficulties[index],
                                      ),
                                    ),
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Trophy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Colors.amber, Color(0xFFFFD700)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.4),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.emoji_events, size: 34, color: Colors.white),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _Badge({required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class Statistics extends StatelessWidget {
  const Statistics({
    required this.statGroupModel,
    required this.provider,
    super.key,
  });

  final StatGroupModel statGroupModel;
  final StatisticsScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: GameSizes.getSymmetricPadding(0.05, 0.011),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(GameSettings.getStatisticTypes.length, (index) {
          StatisticType statisticType = GameSettings.getStatisticTypes[index];
          return StatisticsGroup(
            groupTitle: statisticType.name,
            statistics: statGroupModel.getStats(statisticType),
          );
        }),
      ),
    );
  }
}

class StatisticsGroup extends StatelessWidget {
  const StatisticsGroup({
    required this.groupTitle,
    required this.statistics,
    super.key,
  });

  final String groupTitle;
  final List<StatModel> statistics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: GameSizes.getVerticalPadding(0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            groupTitle.toLowerCase().tr(),
            style: GameTextStyles.statisticsGroupTitle.copyWith(
              fontSize: GameSizes.getHeight(0.027),
              color: Colors.white
            ),
          ),
          SizedBox(height: GameSizes.getHeight(0.005)),
          Column(
            children: List.generate(statistics.length, (index) {
              return StatisticCard(statModel: statistics[index]);
            }),
          ),
        ],
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  const StatisticCard({required this.statModel, super.key});

  final StatModel statModel;

  @override
  Widget build(BuildContext context) {
    // Example: Gamify with color and progress
    final Color cardColor = GameColors.statisticsCard;
    final bool hasProgress = false;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: double.infinity,
      margin: GameSizes.getVerticalPadding(0.007),
      padding: GameSizes.getPadding(0.045),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cardColor.withOpacity(0.95), cardColor.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: GameSizes.getRadius(18),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gamified Icon
          Container(
            decoration: BoxDecoration(
              color: GameColors.roundedButton.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(
              getIconData(statModel.title),
              color: GameColors.roundedButton,
              size: GameSizes.getHeight(0.038),
            ),
          ),
          SizedBox(width: GameSizes.getWidth(0.03)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statModel.title.toLowerCase().tr(),
                  style: GameTextStyles.statisticsCardTitle.copyWith(
                    fontSize: GameSizes.getHeight(0.019),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: GameSizes.getHeight(0.006)),
                Row(
                  children: [
                    Text(
                      statModel.value == null
                          ? '-'
                          : statModel.value.toString(),
                      style: GameTextStyles.statisticsCardValue.copyWith(
                        fontSize: GameSizes.getHeight(0.025),
                        color: Colors.amber.shade700,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData getIconData(String title) {
    switch (title) {
      case GameStrings.gamesStarted:
        return Icons.grid_on_rounded;
      case GameStrings.gamesWon:
        return Icons.workspace_premium_rounded;
      case GameStrings.winRate:
        return Icons.outlined_flag_sharp;
      case GameStrings.winsWithNoMistakes:
        return Icons.sports_score_outlined;
      case GameStrings.bestTime:
        return Icons.timer;
      case GameStrings.averageTime:
        return Icons.timelapse_sharp;
      case GameStrings.bestScore:
        return Icons.star;
      case GameStrings.averageScore:
        return Icons.star_border_purple500;
      case GameStrings.currentWinStreak:
        return Icons.keyboard_double_arrow_right_rounded;
      case GameStrings.bestWinStreak:
        return Icons.double_arrow_sharp;
      default:
        return Icons.grid_on_rounded;
    }
  }
}

class ComparisonBox extends StatelessWidget {
  const ComparisonBox({required this.positive, super.key});

  final bool positive;

  @override
  Widget build(BuildContext context) {
    IconData arrowIcon = positive ? Icons.arrow_drop_up : Icons.arrow_drop_down;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: positive ? GameColors.statisticsUp : GameColors.statisticsDown,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(arrowIcon, color: Colors.white, size: 16),
          const Text('12', style: TextStyle(color: Colors.white, fontSize: 12)),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class StatisticsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatisticsAppBar({
    required this.onTimeInterval,
    required this.difficulties,
    super.key,
  });

  final Function() onTimeInterval;
  final List<Difficulty> difficulties;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      centerTitle: true,
      backgroundColor: GameColors.appBarBackground,
      title: Text(
        "statistics".tr(),
        style: GameTextStyles.statisticsTitle.copyWith(
          fontSize: GameSizes.getWidth(0.045),
        ),
      ),
      leadingWidth: 0,
      leading: const SizedBox(),
      actions: [
        AppBarActionButton(
          icon: Icons.tune,
          onPressed: onTimeInterval,
          iconSize: GameSizes.getWidth(0.07),
        ),
        SizedBox(width: GameSizes.getWidth(0.025)),
      ],
      bottom: TabBar(
        tabAlignment: TabAlignment.start,
        labelColor: GameColors.roundedButton,
        unselectedLabelColor: GameColors.greyColor,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: GameSizes.getWidth(0.04),
        ),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: GameColors.roundedButton.withOpacity(0.15),
        ),
        isScrollable: true,
        tabs: List.generate(
          GameSettings.getDifficulties.length,
          (index) => Tab(
            child: SizedBox(
              height: 38,
              width: 110,
              child: Center(
                child: Text(
                  GameSettings.getDifficulties[index].name.toLowerCase().tr(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(GameSizes.getWidth(0.25));
}

class _CustomProgressBar extends StatelessWidget {
  final double value;
  final double height;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;
  final Duration duration;

  const _CustomProgressBar({
    required this.value,
    this.height = 8,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderRadius = 8,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          AnimatedContainer(
            duration: duration,
            width: value * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: foregroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ],
      ),
    );
  }
}
