


import '../../../libs.dart';

extension BuildContextExtension on BuildContext {
  void pushName(String routeName) {
    Navigator.of(this).pushNamed(routeName);
  }

  void pushReplacementName(String routeName) {
    Navigator.of(this).pushReplacementNamed(routeName);
  }

  Future pushPage(Widget page) {
    return Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  void pop([result]) {
    Navigator.of(this).pop(result);
  }

  void showAppDialog({
    required String title,
    Function? onTapSuccess,
    Widget? widget,
    bool? showCancel,
    String? message,
    Function? cancelButton,
    String?successTitle,String?cancelButtonTitle,
   }) {
    showDialog(
        context: this,
        builder: (BuildContext context) {
          return CustomGeneralAlertDialog(
            title: title,
            showCancel: showCancel ?? false,
            specificBody: widget ??
                CustomTextApp(
                  text: message,
                  size: 6,
                ),
            successButton:successTitle?? "OK",
            cancelOnTap: cancelButton,
            cancelButton:cancelButtonTitle,
            successOnTap: onTapSuccess,
          );
        });
  }

  void showDatePicker(
      {DateTime ?minDate,DateTime?maxDate,DateTime?
      initialDate,required Function onConfirm,DateTimePickerMode?mode,String?dateFormat,}) {
    DatePicker.showDatePicker(this,
        pickerTheme: DateTimePickerTheme(
            confirm: IgnorePointer(
          ignoring: true,
          child: CustomButton(
            onPressed: () {},
            text: 'Confirm',
            buttonColor: AppColors.orange,
            fontSize: 3,
          ),
        )),
        dateFormat: dateFormat,
        pickerMode:mode??DateTimePickerMode.date ,
        maxDateTime: maxDate,
        minDateTime: minDate,
        initialDateTime: initialDate,
        onConfirm: (DateTime dateTime, List<int> data){
          onConfirm(dateTime);
        });
  }
}
