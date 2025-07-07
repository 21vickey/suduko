import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/game_colors.dart';
import '../../../utils/game_routes.dart';
import '../../../utils/game_sizes.dart';
import '../../../utils/game_text_styles.dart';
import '../../../widgets/option_widgets/exports.dart';

class AboutGameScreen extends StatelessWidget {
  const AboutGameScreen({super.key});

  Future<void> launchPage(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      await canLaunchUrl(uri)
          ? await launchUrl(uri)
          : throw 'Could not launch $url';
    } catch (e) {
      debugPrint(e.toString());
      log('error', name: 'AboutGameScreen', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                elevation: 0.5,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                title: Text(
                  "aboutGame".tr(),
                  style: GameTextStyles.optionsScreenAppBarTitle.copyWith(
                    fontSize: GameSizes.getWidth(0.045),
                    color: Colors.white,
                  ),
                ),
                leading: const BackButton(color: Colors.white),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: GameSizes.getSymmetricPadding(0.04, 0.04),
                  child: Column(
                    children: [
                      // Modern glassy app info card
                      Container(
                        padding: GameSizes.getSymmetricPadding(0.04, 0.02),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: GameSizes.getWidth(0.18),
                              height: GameSizes.getWidth(0.18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.10),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(Icons.extension, color: Color(0xFF6D5BFF), size: 64),
                              ),
                            ),
                            SizedBox(width: GameSizes.getWidth(0.04)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'GridHero Sudoku'.tr(args: [' - ']),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: GameSizes.getWidth(0.045),
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: GameSizes.getWidth(0.018)),
                                Text(
                                  'version'.tr(args: ['1.0.0']),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: GameSizes.getWidth(0.038),
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(height: GameSizes.getWidth(0.035)),
                                // Text(
                                //   '© 2023 Recep Oğuzhan Şenoğlu',
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.w400,
                                //     fontSize: GameSizes.getWidth(0.035),
                                //     color: Colors.white60,
                                //   ),
                                // ),
                                // Text(
                                //   'İstanbul / Türkiye',
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.w400,
                                //     fontSize: GameSizes.getWidth(0.035),
                                //     color: Colors.white60,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: GameSizes.getWidth(0.04)),
                      // _ModernOptionGroup(
                      //   options: [
                      //     _ModernOptionWidget(
                      //       title: "privacyPolicy".tr(),
                      //       iconColor: Colors.red,
                      //       iconData: Icons.privacy_tip,
                      //       onTap: () => GameRoutes.goTo(GameRoutes.privacyPolicyScreen, enableBack: true),
                      //     ),
                      //     _ModernOptionWidget(
                      //       title: "termsOfUse".tr(),
                      //       iconColor: Colors.orange,
                      //       iconData: Icons.rule,
                      //       onTap: () => GameRoutes.goTo(GameRoutes.termsOfUseScreen, enableBack: true),
                      //     ),
                      //   ],
                      // ),
                      // _ModernOptionGroup(
                      //   options: [
                      //     _ModernOptionWidget(
                      //       title: "moreApps".tr(),
                      //       iconColor: Colors.green,
                      //       iconData: Icons.apps,
                      //       onTap: () => launchPage('https://play.google.com/store/apps/dev?id=7235038440743748997'),
                      //     ),
                      //     _ModernOptionWidget(
                      //       title: "developerWebsite".tr(),
                      //       iconColor: Colors.blue,
                      //       iconData: Icons.web_asset,
                      //       onTap: () => launchPage('https://recepsenoglu.com/'),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Modern Option Group with card style
class _ModernOptionGroup extends StatelessWidget {
  final List<Widget> options;
  const _ModernOptionGroup({required this.options});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: options,
      ),
    );
  }
}

// Modern Option Widget with icon background and animation
class _ModernOptionWidget extends StatelessWidget {
  final String title;
  final Color iconColor;
  final IconData iconData;
  final VoidCallback onTap;

  const _ModernOptionWidget({
    required this.title,
    required this.iconColor,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.18),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(iconData, color: iconColor, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GameTextStyles.optionsScreenAppBarTitle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
