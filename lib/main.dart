
import 'package:note_app/main_app.dart';

import 'libs.dart';

//

/*
FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':app:mergeDexDebug'.
> Multiple build operations failed.
      Cannot parse result path string:
      Cannot parse result path string:
      Cannot parse result path string:
      Cannot parse result path string:
      Cannot parse result path string:
      Cannot parse result path string:
   > Cannot parse result path string:
   > Cannot parse result path string:
   > Cannot parse result path string:
   > Cannot parse result path string:
   > Cannot parse result path string:
   > Cannot parse result path string:

* Try:
> Run with --stacktrace option to get the stack trace.
> Run with --info or --debug option to get more log output.
> Run with --scan to get full insights.

* Get more help at https://help.gradle.org

BUILD FAILED in 10s
Error: Gradle task assembleDebug failed with exit code 1
*/

//TODO "Due to a previous error, I was unable to complete the grammar check task."
void main() async {


  WidgetsFlutterBinding.ensureInitialized();


  await NoteDatabase.instance.database;


  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor:AppColors.orange,
    statusBarBrightness: Brightness.dark,
  ));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      const MainApp(),
    );
  });
}


