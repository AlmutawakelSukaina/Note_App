


import '../../../libs.dart';

class CustomTextApp extends StatelessWidget {
  final String? text;
  final double? size;
  final FontWeight? font;
  final Color? colors;
  final int? maxLines;
  final int? minLines;
  final TextDecoration? decoration;
  final double? thickness;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Color? decorationColor;
  final List<Shadow>? shadow;
  final TextDirection? textDirection;
  final bool? italic;
  final Color? backgroundColor;

  const CustomTextApp({
    this.text,
    this.size,
    this.font,
    this.colors,
    this.decorationColor,
    this.maxLines,
    this.thickness,
    this.overflow,
    this.textAlign,
    this.decoration,
    super.key,
    this.shadow,
    this.textDirection,
    this.minLines,
    this.italic,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: text,
      child: Text(
        text ?? "",
        semanticsLabel: text,
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
        style: TextStyle(
          shadows: shadow,
          backgroundColor: backgroundColor,
          fontWeight: font ?? FontWeight.normal,
          color: colors ?? Colors.black,
          fontSize: size,
          fontStyle: italic == true ? FontStyle.italic : null,
          overflow: overflow,
          decoration: decoration ?? TextDecoration.none,
          decorationThickness: thickness ?? 2.5,
          decorationColor: decorationColor,
          fontFamily: appFont,
        ),
        textDirection: textDirection,
      ),
    );
  }
}

