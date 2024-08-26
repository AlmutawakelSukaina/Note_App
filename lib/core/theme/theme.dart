

import '../../libs.dart';
const String appFont="Amiri";
const double defaultBorderRadius=10;
ThemeData theme = ThemeData(
   brightness: Brightness.light,
  primaryColor: AppColors.orange,
   splashColor:Colors.orange[50],

   highlightColor:Colors.orange[50],
  splashFactory: NoSplash.splashFactory,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.orange,
    selectionColor: Colors.orange[50],
    selectionHandleColor: AppColors.orange,
  ),



);
