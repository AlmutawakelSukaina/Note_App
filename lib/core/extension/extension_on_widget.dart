
import 'package:note_app/main_app.dart';

import '../../../libs.dart';

extension WidgetExtension on Widget {
  Widget onTap(onTap) => InkWell(onTap: onTap, child: this);

  //padding
  Widget symmetricPadding(double h, double w) => Padding(
    padding: EdgeInsets.symmetric(
      vertical:  h,
      horizontal:  w,
    ),
    child: this,
  );



  Widget roundedWidget ({bool ?hasBorderSide,Color ?borderColor,Color?
  color,double ?elevation,double? radius,double?borderWidth,BorderSide?borderSide})
  {
    return Material(
      elevation: elevation??1,
      color:color?? AppColors.white,
      shadowColor: Colors.black,

      type: MaterialType.card,
      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(radius??defaultBorderRadius),
        side:borderSide ?? (hasBorderSide!=false?
        BorderSide(color:borderColor??color?? AppColors.grey, width: borderWidth??1)
            :BorderSide.none),
      ),

      child: this,
    );
  }
   Widget containerWithBorderSide(Color color )
   {
     return Container(
       padding: const EdgeInsets.symmetric(  vertical:2,
         horizontal: 2,
       ),
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10),
         border: Border(
           left: BorderSide(
             color: color,
             // Color for the left border
             width: 2, // Width of the border
           ),
         ),
       ),child: this,
     ).roundedWidget();
   }
Widget fullWidth()
{
  return SizedBox(

    width:Responsive.fullWidth(AppRouter.navigatorKey.currentContext!) ,
    child: this,
  );
}
}

