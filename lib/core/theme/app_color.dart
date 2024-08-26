
import '../../libs.dart';

class AppColors
{
  static Color orange=getColorFromHex("#e28309");
  static Color grey=Colors.grey[200]!;
  static Color white=Colors.white;
  static Color black=Colors.black;
  static Color red=Colors.red[900]!;
  static Color backgroundColor=Colors.grey[50]!;

  static Color getColorFromHex(String hexColor) {
    // Remove leading '#' if present
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }

    // Parse hex color
    int parsedColor = int.parse(hexColor, radix: 16);

    // Return Color object
    return Color(parsedColor | 0xFF000000);
  }

  static List<Color> colorsEvent = [
    const Color(0xFF4CAF50), // Green
    const Color(0xFF2196F3), // Blue
    const Color(0xFFFF5722), // Orange
    const Color(0xFFFFC107), // Yellow
    const Color(0xFF9C27B0), // Purple
  ];
}