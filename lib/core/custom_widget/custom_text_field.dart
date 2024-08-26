



import '../../libs.dart';

class CustomTextField extends StatefulWidget {
  final IconData? icon;
  final bool suffixShowHidePassword;
  final String? hint;
  final bool? showHint;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textFormatter;
  final String? initialValue;
  final dynamic height;
  final dynamic prefix;
  final String? suffixText;
  final int? maxLines;
  final double? borderRadius;
   final InputDecoration? inputDecoration;
  final Function? onSaved;
  final Function? onChange;
  final Function? validator;
   final Function? onFieldSubmitted;
  final Function? onTap;
   final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final bool? autoFocus;
  final bool? enabled;
  final bool? enableBorder;
  final TextStyle? style;
  final bool? read;
  final double? scrollPadding;
  final AutovalidateMode? autoValidate;
  final TextDirection? textDirection;
  final bool? roundedBorder;
  final InputBorder? inputBorder;
  final InputBorder? errorBorder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool?required;
  final Color?fillColor;
  const CustomTextField({
    super.key,
    this.icon,
    this.textDirection,
    this.hint,
    this.suffixText,
     this.scrollPadding,
     this.showHint,
    this.onChange,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.textEditingController,
    this.focusNode,
    this.textInputAction,
    this.autoFocus,
    this.read,
    this.textInputType,
    this.suffixShowHidePassword = false,
    this.textFormatter,
    this.height,
    this.maxLines,
    this.initialValue,
    this.borderRadius,
    this.enableBorder,
    this.enabled,
    this.onTap,
    this.prefix,
    this.inputDecoration,
    this.style,
    this.autoValidate,
    this.roundedBorder,
    this.inputBorder,
    this.suffixIcon,
    this.prefixIcon, this.required, this.fillColor, this.errorBorder,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;
  dynamic W;



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    W =Responsive.width(context);
    return widget.roundedBorder != false
        ? textField().roundedWidget(hasBorderSide: false,color: widget.fillColor)
        : textField();
  }

  Widget textField() {
    return TextFormField(
      textDirection: widget.textDirection,


      cursorColor: Colors.grey,
      scrollPadding: widget.scrollPadding != null
          ? EdgeInsets.only(bottom: widget.scrollPadding!)
          : const EdgeInsets.only(bottom: 1),
      obscureText: widget.suffixShowHidePassword ? obscureText : false,
      textInputAction: widget.textInputAction,
      readOnly: widget.read ?? false,
      autovalidateMode:
      widget.autoValidate ?? AutovalidateMode.onUserInteraction,
      showCursor: true,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus ?? false,
      enabled: widget.enabled ?? true,
      keyboardType: widget.textInputType,
      controller: widget.textEditingController,
      initialValue: widget.initialValue,


       style: widget.style ??
          TextStyle(fontSize: W * 4, fontFamily: appFont,
          ),
      decoration: widget.inputDecoration ??
          InputDecoration(
            errorMaxLines: 2,
            contentPadding: EdgeInsets.fromLTRB(W * 4, W, W * 4, W),


            filled: true,
            fillColor:widget.fillColor?? AppColors.white,
            enabledBorder: widget.inputBorder ?? outLineBorderWidget(),
            focusedBorder: widget.inputBorder ?? outLineBorderWidget(),
            errorBorder:widget.errorBorder??
                widget.inputBorder ?? outLineBorderWidget(color: AppColors.red),
            border: widget.inputBorder ?? outLineBorderWidget(),



            label : RichText(
                text: TextSpan(
                    text: widget.hint,
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: appFont,
                        fontSize:Responsive.width(context)
                            *(Responsive.screenSize(context,
                                3.3, 2.5, 1.7)),
                        fontWeight: FontWeight.bold),
                    children: widget.required==true?const [

                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ]:const[])),
            hintText: widget.showHint == true ? widget.hint : null,
            suffixIcon:             widget.suffixShowHidePassword == true ? suffixWidget() : widget.suffixIcon,
            prefixIcon: widget.prefixIcon,

            // // labelStyle: TextStyle(
            // //     color: Colors.grey,
            // //     fontFamily: Font.ibm,
            // //     fontSize:Responsive.width(context) * 3,
            // //     fontWeight: FontWeight.bold),
            // suffix:
            //     widget.suffixShowHidePassword == true ? suffixWidget() : null,
          ),
      onTap: () {
        if (widget.onTap != null) widget.onTap!();

        if (widget.textEditingController != null) {
          if (widget.textEditingController!.selection ==
              TextSelection.fromPosition(TextPosition(
                  offset: widget.textEditingController!.text.length - 1))) {
            widget.textEditingController!.selection =
                TextSelection.fromPosition(TextPosition(
                    offset: widget.textEditingController!.text.length));
          }
        }
      },
      validator: (value) {
        if (widget.validator != null && value != null) {
          return widget.validator!(value);
        } else {
          return null;
        }
      },
      onFieldSubmitted: (value) {
        if (widget.onFieldSubmitted != null) {
          widget.onFieldSubmitted!(value);
        }
      },
      onSaved: (value) {
        if (widget.onSaved != null) widget.onSaved!(value);
      },
      onChanged: (String value) {
        if (widget.onChange != null) widget.onChange!(value);


      },
      inputFormatters: widget.textFormatter,
      maxLines: widget.maxLines ?? 1,
    );
  }

  Widget suffixWidget() {
    return SizedBox(
      height: Responsive.screenSize(context, 45, 67, 85),
      child: GestureDetector(
        child: Icon(
          obscureText == true ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
          size:Responsive.screenSize(context, W * 5, W * 5, W * 3) ,
        ),
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
      ),
    ).symmetricPadding(
      0,
      1,
    );
  }
}
OutlineInputBorder outLineBorderWidget({Color?color})
{
  return   const OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius))
  );
}
