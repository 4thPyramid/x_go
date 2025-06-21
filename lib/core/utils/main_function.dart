
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

// //! Function to get the  date and time format
// String dateFormatMethod({
//   required String dateTimeAsString,
//   String? pattern,
//   bool mustBeEnglish = false,
// }) {
//   return DateFormat(
//     pattern ?? "yyyy-MM-dd HH:mm:ss",
//     mustBeEnglish
//         ? "en-US"
//         : (EasyLocalization.of(GlobalContextExt.globalContext!)
//                 ?.currentLocale
//                 ?.languageCode ??
//             "en"),
//   ).format(
//     DateTime.tryParse(dateTimeAsString) ?? DateTime.now(),
//   );
// }

// //! Function to check if the language is English
// bool isEnglish() => GlobalContextExt.globalContext == null
//     ? HiveMethods.getLang() == "en"
//     : (EasyLocalization.of(GlobalContextExt.globalContext!)
//                 ?.currentLocale
//                 ?.languageCode ??
//             "en") ==
//         "en";

// //! Function to convert hex string to Color
// Color hexToColor(String hexColor) {
//   // Ensure the string starts with 0xFF for opacity
//   if (hexColor.length == 6) {
//     hexColor = 'FF$hexColor'; // Prepend 'FF' for full opacity
//   }
//   return Color(int.parse(hexColor, radix: 16));
// }

// //!------------------     imageHeroFunction    --------------------
// Future<dynamic> imageHeroFunction(BuildContext context, var imageProvider,
//     {String? tag}) {
//   return context.push(
//     Scaffold(
//       body: InkWell(
//         onTap: () {
//           context.pop();
//         },
//         child: Hero(
//             tag: tag ?? imageProvider,
//             child: Container(
//               color: AppColors.blackColor(),
//               width: double.infinity,
//               height: double.infinity,
//               child: Image(image: imageProvider),
//             )),
//       ),
//     ),
//   );
// }

// //!--------------- timeAgo Function -----------------------
// String timeAgo(String dateTimeString) {
//   DateTime now = DateTime.now();
//   DateTime inputDateTime = DateTime.parse(dateTimeString);
//   Duration difference = now.difference(inputDateTime);

//   if (difference.inSeconds < 60) {
//     return isEnglish() ? "1 minute ago" : "منذ دقيقة";
//   } else if (difference.inMinutes < 60) {
//     return isEnglish()
//         ? "${difference.inMinutes} minutes ago"
//         : "منذ ${difference.inMinutes} دقيقة";
//   } else if (difference.inHours < 24 && difference.inMinutes % 60 != 0) {
//     return isEnglish()
//         ? "${difference.inHours} hours ${difference.inMinutes - difference.inHours * 60} minutes ago"
//         : "منذ ${difference.inHours} ساعة و ${difference.inMinutes - difference.inHours * 60} دقيقة";
//   } else if (difference.inMinutes % 60 == 0) {
//     return isEnglish()
//         ? "${difference.inHours} hours ago"
//         : "منذ ${difference.inHours} ساعة";
//   } else if (difference.inDays < 30) {
//     return isEnglish()
//         ? "${difference.inDays} days ago"
//         : "منذ ${difference.inDays} يوم";
//   } else if (difference.inDays < 365) {
//     int months = (difference.inDays / 30).floor();
//     return isEnglish() ? "$months months ago" : "منذ $months شهر";
//   } else {
//     int years = (difference.inDays / 365).floor();
//     return isEnglish() ? "$years years ago" : "منذ $years سنة";
//   }
// }

// //! to use color random color
// Color getColorForIndex(int index) {
//   x.Random random = x.Random(index); // Seed random with the index
//   return index == 0
//       ? AppColors.mainAppColor().withOpacity(0.5)
//       : Color((random.nextDouble() * 0x276AFF).toInt()).withOpacity(1.0);
// }

//!  /show button model sheet ///
customBottomSheet({
  required BuildContext context,
  required Widget content,
  ScrollController? scrollController,
  double? paddingHorizontal,
  double? paddingVertical,
  bool? isDismissible,
}) {
  return showModalBottomSheet(
    showDragHandle: false,
    enableDrag: true,
    scrollControlDisabledMaxHeightRatio: 0.9,
    useSafeArea: true,
    isDismissible: isDismissible ?? true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    barrierColor: AppColors.black.withOpacity(0.5),
    backgroundColor: AppColors.white,
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child:
          SingleChildScrollView(controller: scrollController, child: content),
    ),
  );
}

///! Show Alert Dialog ///

customAlertDialog({
  required Widget content,
  bool? barrierDismissible,
  required BuildContext context,
  double? marginHPadding,
  double? marginVPadding,
  double? radius,
  duration,
  MainAxisAlignment? mainAxisAlignment,
  double? hPadding,
  double? vPadding,
  double? width,
  type,
}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      builder: (context) => Column(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius ?? 20.r),
                    color: Colors.white),
                padding: EdgeInsets.symmetric(
                    horizontal: hPadding ?? 0.0, vertical: vPadding ?? 0.0),
                margin: EdgeInsets.symmetric(
                    horizontal: marginHPadding ?? 0.0,
                    vertical: marginVPadding ?? 0.0),
                child: Material(
                  color: Colors.white,
                  child: content,
                ),
              ),
            ],
          ));
}
