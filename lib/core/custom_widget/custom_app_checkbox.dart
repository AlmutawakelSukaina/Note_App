import '../../libs.dart';

class CustomAppCheckBox extends StatelessWidget {
  final ValueNotifier<bool> checkBox;
  final String title;
  const CustomAppCheckBox({super.key, required this.checkBox, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        ValueListenableBuilder(valueListenable: checkBox,

            builder: (context, value, child) {

           return   Checkbox(
               activeColor: AppColors.orange,
               value: value, onChanged: (bool? value){
             checkBox.value=value??false;
           });

            },),


        CustomTextApp(
          text: title,
          size: 20,
        )
      ],
    );
  }
}
