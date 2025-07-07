// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// import '../../../utils/game_colors.dart';
// import '../../../utils/game_sizes.dart';
// import '../../../widgets/button/custom_icon_button.dart';
// import '../../../widgets/button/custom_text_button.dart';

// class HowToPlayScreen extends StatefulWidget {
//   const HowToPlayScreen({super.key});

//   @override
//   State<HowToPlayScreen> createState() => _HowToPlayScreenState();
// }

// class _HowToPlayScreenState extends State<HowToPlayScreen> {
//   late PageController _pageController;
//   int _currentPage = 0;
//   bool _loading = true;
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);
//     Future.delayed(const Duration(milliseconds: 500), () {
//       setState(() {
//         _loading = false;
//       });
//     });
//   }

//   void _onPageChanged(int index) {
//     if (index < 0 || index > 2) return;
//     setState(() {
//       _currentPage = index;
//       _pageController.jumpToPage(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leadingWidth: 0,
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         title: Text(
//           "howToPlay".tr(),
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: GameSizes.getWidth(0.045),
//           ),
//         ),
//         leading: const SizedBox(),
//         actions: [CustomTextButton(text: "skip".tr())],
//       ),
//       body: Padding(
//         padding: GameSizes.getHorizontalPadding(0.015),
//         child: Column(
//           children: [
//             Visibility(
//               visible: !_loading,
//               replacement: Expanded(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 1,
//                       child: LinearProgressIndicator(
//                         color: GameColors.appBarActions,
//                         backgroundColor: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               child: Expanded(
//                 child: PageView.builder(
//                     itemCount: 3,
//                     controller: _pageController,
//                     onPageChanged: _onPageChanged,
//                     physics: const NeverScrollableScrollPhysics(),
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) {
//                       return SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Image.asset(
//                               'assets/images/how_to_play_${index + 1}.png',
//                               fit: BoxFit.fitWidth,
//                             ),
//                             SizedBox(height: GameSizes.getHeight(0.04)),
//                             Padding(
//                                 padding: GameSizes.getHorizontalPadding(0.045),
//                                 child:
//                                     // index > 0 ?
//                                     Text(
//                                   "howToPlay$index".tr(),
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: GameSizes.getWidth(0.041),
//                                   ),
//                                 )
//                                 // :
//                                 // RichText(
//                                 //     textAlign: TextAlign.center,
//                                 //     text: TextSpan(
//                                 //         style: TextStyle(
//                                 //           color: Colors.black,
//                                 //           fontSize: GameSizes.getWidth(0.041),
//                                 //         ),
//                                 //         children: [
//                                 //           const TextSpan(
//                                 //             text:
//                                 //                 "A Sudoku puzzle starts with a grid where certain numbers are already positioned. The objective is to fill in the remaining cells with numbers 1 to 9 so that each digit appears exactly once in every ",
//                                 //           ),
//                                 //           TextSpan(
//                                 //             text: "rows",
//                                 //             style: TextStyle(
//                                 //               color: Colors.yellow.shade700,
//                                 //               fontWeight: FontWeight.bold,
//                                 //             ),
//                                 //           ),
//                                 //           const TextSpan(text: ", "),
//                                 //           TextSpan(
//                                 //             text: "columns",
//                                 //             style: TextStyle(
//                                 //               color: Colors.green.shade700,
//                                 //               fontWeight: FontWeight.bold,
//                                 //             ),
//                                 //           ),
//                                 //           const TextSpan(text: " and "),
//                                 //           TextSpan(
//                                 //             text: "3x3 boxes",
//                                 //             style: TextStyle(
//                                 //               color: Colors.blue.shade700,
//                                 //               fontWeight: FontWeight.bold,
//                                 //             ),
//                                 //           ),
//                                 //           const TextSpan(
//                                 //             text:
//                                 //                 ". Examine the grid to identify the suitable numbers for each cell.",
//                                 //           ),
//                                 // ]),
//                                 // ),
//                                 ),
//                           ],
//                         ),
//                       );
//                     }),
//               ),
//             ),
//             Padding(
//               padding: GameSizes.getHorizontalPadding(0.04)
//                   .copyWith(bottom: GameSizes.getHeight(0.03)),
//               child: Row(
//                 children: [
//                   Opacity(
//                     opacity: _currentPage == 0 ? 0 : 1,
//                     child: CustomIconButton(
//                       icon: Icons.arrow_back,
//                       onPressed: () {
//                         _onPageChanged(_currentPage - 1);
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       height: GameSizes.getWidth(0.02),
//                       alignment: Alignment.center,
//                       child: Center(
//                         child: ListView.builder(
//                             itemCount: 3,
//                             primary: false,
//                             shrinkWrap: true,
//                             scrollDirection: Axis.horizontal,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal: GameSizes.getWidth(0.01)),
//                                 width: GameSizes.getWidth(0.02),
//                                 height: GameSizes.getWidth(0.02),
//                                 decoration: BoxDecoration(
//                                   color: index == _currentPage
//                                       ? GameColors.appBarActions
//                                       : GameColors.appBarActions
//                                           .withOpacity(0.5),
//                                   shape: BoxShape.circle,
//                                 ),
//                               );
//                             }),
//                       ),
//                     ),
//                   ),
//                   if (_currentPage == 2)
//                     CustomIconButton(
//                       icon: Icons.check,
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     )
//                   else
//                     CustomIconButton(
//                       icon: Icons.arrow_forward,
//                       onPressed: () {
//                         _onPageChanged(_currentPage + 1);
//                       },
//                     ),
//                 ],
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
import '../../../utils/game_colors.dart';
import '../../../utils/game_sizes.dart';
import '../../../widgets/button/custom_icon_button.dart';
import '../../../widgets/button/custom_text_button.dart';

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({super.key});

  @override
  State<HowToPlayScreen> createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends State<HowToPlayScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _loading = false;
      });
    });
  }

  void _onPageChanged(int index) {
    if (index < 0 || index > 2) return;
    setState(() {
      _currentPage = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "howToPlay".tr(),
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: GameSizes.getWidth(0.05),
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          CustomTextButton(
            text: "skip".tr(),
            textStyle: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Padding(
            padding: GameSizes.getHorizontalPadding(0.015),
            child: Column(
              children: [
                Visibility(
                  visible: !_loading,
                  replacement: Expanded(
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 2,
                          child: LinearProgressIndicator(
                            color: Colors.cyanAccent,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: Expanded(
                    child: PageView.builder(
                        itemCount: 3,
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 25,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'assets/images/how_to_play_${index + 1}.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: GameSizes.getHeight(0.04)),
                              Padding(
                                padding: GameSizes.getHorizontalPadding(0.045),
                                child: Text(
                                  "howToPlay$index".tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: GameSizes.getWidth(0.045),
                                    fontWeight: FontWeight.w600,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: GameSizes.getHorizontalPadding(0.04)
                      .copyWith(bottom: GameSizes.getHeight(0.03)),
                  child: Row(
                    children: [
                      Opacity(
                        opacity: _currentPage == 0 ? 0 : 1,
                        child: CustomIconButton(
                          icon: Icons.arrow_back_ios_new,
                          onPressed: () {
                            _onPageChanged(_currentPage - 1);
                          },
                          iconColor: Colors.white,
                          backgroundColor: Colors.white10,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: GameSizes.getWidth(0.02),
                          alignment: Alignment.center,
                          child: Center(
                            child: ListView.builder(
                              itemCount: 3,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: GameSizes.getWidth(0.01)),
                                  width: GameSizes.getWidth(0.02),
                                  height: GameSizes.getWidth(0.02),
                                  decoration: BoxDecoration(
                                    gradient: index == _currentPage
                                        ? const LinearGradient(
                                            colors: [Colors.cyan, Colors.blue],
                                          )
                                        : null,
                                    color: index == _currentPage
                                        ? null
                                        : Colors.white24,
                                    shape: BoxShape.circle,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      CustomIconButton(
                        icon:
                            _currentPage == 2 ? Icons.check : Icons.arrow_forward_ios,
                        onPressed: () {
                          if (_currentPage == 2) {
                            Navigator.pop(context);
                          } else {
                            _onPageChanged(_currentPage + 1);
                          }
                        },
                        iconColor: Colors.white,
                        backgroundColor: Colors.white10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
