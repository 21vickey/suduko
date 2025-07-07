import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../mixins/app_review_mixin.dart';
import '../../mixins/share_mixin.dart';
import '../../services/localization_manager.dart';
import '../../utils/exports.dart';
import '../../utils/game_routes.dart';
import '../../widgets/button/custom_text_button.dart';
import '../../widgets/option_widgets/exports.dart';
import 'options_screen_provider.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen>
    with ShareMixin, AppReviewMixin {
  @override
  void initState() {
    super.initState();
    onStateChange = () => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OptionsScreenProvider>(
      create: (context) => OptionsScreenProvider(),
      child: Consumer<OptionsScreenProvider>(
        builder: ((context, provider, _) {
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
                      leadingWidth: 0,
                      centerTitle: true,
                      backgroundColor: Colors.transparent,
                      title: Text(
                        "options".tr(),
                        style: GameTextStyles.optionsScreenAppBarTitle.copyWith(
                          fontSize: GameSizes.getWidth(0.045),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: const SizedBox.shrink(),
                      actions: [
                        CustomTextButton(
                          text: "done".tr(),
                          textStyle: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: GameSizes.getSymmetricPadding(0.04, 0.02),
                        child: Column(
                          children: [
                            // _ModernOptionGroup(
                            //   options: [
                            //     _ModernOptionWidget(
                            //       title: LocalizationManager.currentLanguageName,
                            //       iconColor: Colors.pink,
                            //       iconData: Icons.language,
                            //       onTap: () => LocalizationManager.changeLocale(
                            //         context,
                            //         LocalizationManager.currentLocale.languageCode == 'en'
                            //             ? LocalizationManager.supportedLocales[1]
                            //             : LocalizationManager.supportedLocales[0],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            _ModernOptionGroup(
                              options: [
                                _ModernOptionWidget(
                                  title: "howToPlay".tr(),
                                  iconColor: Colors.green,
                                  iconData: Icons.school,
                                  onTap: () => GameRoutes.goTo(GameRoutes.howToPlayScreen, enableBack: true),
                                ),
                                _ModernOptionWidget(
                                  title: "rules".tr(),
                                  iconColor: Colors.lightBlue,
                                  iconData: Icons.menu_book_rounded,
                                  onTap: () => GameRoutes.goTo(GameRoutes.rulesScreen, enableBack: true),
                                ),
                              ],
                            ),
                            _ModernOptionGroup(
                              options: [
                                _ModernOptionWidget(
                                  title: "aboutGame".tr(),
                                  iconColor: Colors.blue.shade700,
                                  iconData: Icons.info,
                                  onTap: () => GameRoutes.goTo(GameRoutes.aboutScreen, enableBack: true),
                                ),
                                // _ModernOptionWidget(
                                //   title: "rateUs".tr(),
                                //   iconColor: Colors.yellow,
                                //   iconData: Icons.star,
                                //   loading: reviewLoading,
                                //   onTap: () => openStoreListing(),
                                // ),
                                _ModernOptionWidget(
                                  title: "share".tr(),
                                  iconColor: Colors.orange,
                                  iconData: Icons.share,
                                  loading: shareLoading,
                                  onTap: () => shareApp("shareText".tr(args: [
                                    'https://play.google.com/store/apps/details?id=com.recepsenoglu.sudoku'
                                  ])),
                                ),
                              ],
                            ),
                          ],
                        ),
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
  final bool loading;

  const _ModernOptionWidget({
    required this.title,
    required this.iconColor,
    required this.iconData,
    required this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: loading ? null : onTap,
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
            if (loading)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.amber,
                  strokeWidth: 2.2,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
