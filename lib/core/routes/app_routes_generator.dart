








import '../../../libs.dart';

class AppRouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.addNote:
        return MaterialPageRoute(builder: (_) => const NoteAdd());
      case AppRoutes.viewNote:
        return MaterialPageRoute(builder: (_) => const NoteViewPage());


      default:
      // If route not found, navigate to a default error page
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}