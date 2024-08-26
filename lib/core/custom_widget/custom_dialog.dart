




import '../../../libs.dart';

class CustomGeneralAlertDialog extends StatefulWidget {
  final String? title;
  final Widget? titleWidget;
  final dynamic body;
  final String? successButton;
  final String? cancelButton;
  final Function? successOnTap;
  final Function? cancelOnTap;
  final bool showCancel;
  final bool fromLogin;
  final Widget? specificBody;
  final double?titleFontSize;
  const CustomGeneralAlertDialog(
      {super.key,
        this.title,
        this.body,
        this.successButton,
        this.cancelButton,
        this.successOnTap,
        this.cancelOnTap,
        this.showCancel = false,
        this.fromLogin = false,this.specificBody, this.titleFontSize, this.titleWidget});

  @override
  CustomGeneralAlertDialogState createState() =>
      CustomGeneralAlertDialogState();
}

class CustomGeneralAlertDialogState extends State<CustomGeneralAlertDialog> {
  //------------------------------- Variables ----------------------------------
  @override
  void initState() {
    super.initState();
  }

  //------------------------------- Dispose ----------------------------------
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          1.pw,
          Container(
            alignment: AlignmentDirectional.center,
            child:  widget.titleWidget??CustomTextApp(text: widget.title,
              font:FontWeight.bold , textAlign:
              TextAlign.center,size: widget.titleFontSize??7,colors: AppColors.orange,),),


          SizedBox(
              width:Responsive.width(context) * 6,
              child: Visibility(
                visible: widget.showCancel,
                child: const CancelWidget(),
              )),
        ],
      ),

      contentPadding: EdgeInsets.symmetric(
        vertical: Responsive.height(context) * 2,
        horizontal:
        Responsive.width(context) * 5,


      ),
      actionsAlignment: MainAxisAlignment.center,
      content:widget.specificBody?? SingleChildScrollView(
        child: SizedBox(
          width: Responsive.fullWidth(context)* Responsive.screenSize(context, 1, .6, .5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.body.runtimeType == String
                  ?CustomTextApp(text: widget.body,size:4 )
                  : widget.body
            ],
          ),
        ),
      ),
      actions: <Widget>[
        widget.successButton == null
            ? const Nothing()
            : ButtonDialog(widget.successButton, widget.successOnTap,
            AppColors.orange,FontWeight.bold),
        widget.cancelButton == null
            ? const Nothing()
            : ButtonDialog(widget.cancelButton, widget.cancelOnTap,Colors.white,border: true
            ,FontWeight.normal,textColor: AppColors.black,),
      ],
    );
  }

}

class ButtonDialog extends StatelessWidget {
  final String? title;
  final Function ?onTap;
  final Color?color;
  final FontWeight?fontWeight;
  final bool?border;
  final Color?textColor;
  const ButtonDialog(this.title, this.onTap, this.color, this.fontWeight,{super.key, this.border, this.textColor});

  @override
  Widget build(BuildContext context) {
    return
      CustomButton(

          onPressed: (){
        if(onTap!=null) {
          onTap!();
        } else {
          context.pop();
        }
      }, text: title??"",buttonColor: color,fontSize: 4.2,
      border: border,
        textColor: textColor
      );

  }
}
class CancelWidget extends StatelessWidget {
  const CancelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Icon(
     Icons.cancel,
     color: AppColors.grey,
    ).onTap((){
      context.pop();
    });
  }
}
