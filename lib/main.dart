import 'package:all_news/homePage.dart';
import 'package:all_news/selectLanguage.dart';
import 'package:all_news/widgets/admob_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'introScreen.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = (prefs.getInt("initScreen"));
  await prefs.setInt("initScreen", 1);
  print('initScreen $initScreen');

  AdmobServices.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
        ),
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      initialRoute: initScreen == 0 || initScreen == null ? "intro" : "/",
      routes: {
        '/': (context) => HomePage(),
        "intro": (context) => IntroScreen(),
        "language": (context) => SelectLanguage(),
      },
    );
  }
}
