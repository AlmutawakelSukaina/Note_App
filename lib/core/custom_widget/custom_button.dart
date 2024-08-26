
import '../../../libs.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final Color ?buttonColor;
  final Color ?textColor;
  final bool?border;
  final double?fontSize;
  final double?elevation;
  final FontWeight?fontWeight;
  final double?radius;
  const CustomButton({super.key, required this.onPressed
    , required this.text, this.buttonColor, this.textColor, this.border,
    this.fontSize, this.elevation, this.fontWeight, this.radius,});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: () {
        // if (!loading) {
          onPressed();
        // }
      },

      style: ElevatedButton.styleFrom(
        backgroundColor:/* loading ? AppColors.grey : */(buttonColor ??
            AppColors.orange),
        shadowColor: Colors.orange[50],
        elevation:elevation,


        side: border == true ?
        const BorderSide(color: Colors.black38, width: 1) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              radius?? defaultBorderRadius), // Adjust the radius here
        ),
        // Change background color here
      ),

      child:/* loading ? const LoadingIndicator() :*/
      CustomTextApp(
        text: text,
        colors: textColor??AppColors.white,
        size: 20,
        font:fontWeight,
      ).symmetricPadding(1, 0),
    )
    ;
  }
}
