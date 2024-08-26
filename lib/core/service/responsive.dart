import '../../libs.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({super.key,

    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  static double width(BuildContext context) =>    MediaQuery.of(context).size.width/100;
  static double fullWidth(BuildContext context) =>    MediaQuery.of(context).size.width;
  static double height(BuildContext context) =>    MediaQuery.of(context).size.height/100;
  static double fullHeight(BuildContext context) =>    MediaQuery.of(context).size.height;
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
          MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double screenSize(BuildContext context,double mobile,double table,double desktop) =>
      isMobile(context)?mobile:isTablet(context)?table:desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        }
        else if (constraints.maxWidth >= 650) {
          return tablet;
        }
        else {
          return mobile;
        }
      },
    );
  }
}
