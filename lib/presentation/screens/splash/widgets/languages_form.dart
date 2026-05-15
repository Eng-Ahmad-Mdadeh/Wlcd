// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flag/flag.dart' as fl;
//
// class LanguagesForm extends StatefulWidget {
//   final List<LanguagesModel> languages;
//   final bool isUpdateLang;
//
//   const LanguagesForm({
//     super.key,
//     required this.languages,
//     this.isUpdateLang = false,
//   });
//
//   @override
//   State<LanguagesForm> createState() => _LanguagesFormState();
// }
//
// class _LanguagesFormState extends State<LanguagesForm> {
//   final PageController _pageController = PageController(viewportFraction: 0.3);
//   int _selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(height: AppHeight.h20),
//         SizedBox(
//           height: AppHeight.h155,
//           child: PageView.builder(
//             controller: _pageController,
//             itemCount: widget.languages.length,
//             onPageChanged: (index) {
//               setState(() {
//                 _selectedIndex = index;
//               });
//             },
//             itemBuilder: (context, index) {
//               bool isSelected = index == _selectedIndex;
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _selectedIndex = index;
//                     _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
//                   });
//                 },
//                 child: Column(
//                   children: [
//                     AnimatedContainer(
//                       width: AppWidth.w110,
//                       height: AppHeight.h110,
//                       duration: Duration(milliseconds: 150),
//                       curve: Curves.easeInOut,
//                       padding: EdgeInsets.all(isSelected ? 5.0 : 16.0),
//                       margin: EdgeInsets.all(6.0),
//                       decoration: BoxDecoration(
//                         border: isSelected ? Border.all(color: AppColors.blueText, width: 1.7) : null,
//                         shape: BoxShape.circle,
//                       ),
//                       child: SizedBox(
//                         child: fl.Flag.fromString(
//                           widget.languages[index].countryCode ?? '',
//                           borderRadius: AppRadius.r100,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     SectionTitle(
//                       text: widget.languages[index].name!,
//                       color: isSelected ? AppColors.blueText : AppColors.white,
//                       fontWeight: isSelected ? AppFontWeight.bold : AppFontWeight.medium,
//                     ).animate(key: ValueKey(isSelected)).fade(duration: 250.ms),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         MendarSubmitButton(
//           marginTop: AppMarginHeight.m35,
//           marginStart: AppMarginWidth.m25,
//           marginEnd: AppMarginWidth.m25,
//           title: "تأكيد",
//           onPressed: () {
//             context.pop();
//             context.read<LanguageCubit>().setLang(widget.languages[_selectedIndex].code!);
//             if (widget.isUpdateLang) {
//               SplashRoute().go(context);
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
