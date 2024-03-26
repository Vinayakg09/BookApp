import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:book_app/View/demoHome.dart';
import 'package:book_app/View/seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'View/loginPage.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://bpdtidynqhkoynoiasjl.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJwZHRpZHlucWhrb3lub2lhc2psIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDc0OTMzNjcsImV4cCI6MjAyMzA2OTM2N30.DQDkZ6y477Vf2e5FbAwiAMg1wDxh9sIwiucV8HBSmuw",
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((value)=>runApp(MyApp(prefs: prefs,)));
}

String getUserEmail(SharedPreferences prefs) {
  return prefs.getString('userEmail') ?? '';
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String email = getUserEmail(prefs);
    return MaterialApp(
      title: 'Book Bazaar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0E1514),
        ),
        scaffoldBackgroundColor: const Color(0xFF0E1514),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
          backgroundColor: const Color(0xFF0E1514),
          splash: const Column(
            children: [
              Icon(
                Icons.book,
                size: 30,
                color: Colors.white,
              ),
              Text(
                "Welcome!!",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
          duration: 1400,
          pageTransitionType: PageTransitionType.rightToLeft,
          nextScreen: email.isNotEmpty ? const DemoHome() : LoginPage()),
    );
  }
}
