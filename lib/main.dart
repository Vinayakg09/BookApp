import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:book_app/View/genrePage/bloc/genre_bloc.dart';
import 'package:book_app/View/homePage/page/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:book_app/View/loginPage/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'View/loginPage/page/loginPage.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: "${dotenv.env['SupabaseURL']}",
    anonKey: "${dotenv.env['anonKey']}",
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp(
            prefs: prefs,
          )));
}

Future<void> kickStartApi() async {
  debugPrint("##############");
  await http.get(Uri.parse("${dotenv.env['API_baseURL']}"));
  debugPrint("!!!!!!!!!");
}

String getUserEmail(SharedPreferences prefs) {
  return prefs.getString('userEmail') ?? '';
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    String email = getUserEmail(prefs);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => GenreBloc()), // Add GenreBloc here
        // Add more Blocs here if needed
      ],
      child: MaterialApp(
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
        home: FutureBuilder(
          future: kickStartApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AnimatedSplashScreen(
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
                  //duration: 1400,
                  pageTransitionType: PageTransitionType.rightToLeft,
                  nextScreen: email.isNotEmpty ? const Home() : LoginPage());
            } else if (snapshot.hasError) {
              return const Center(
                child:
                    Text("Something went wrong, currently app unavailable!!"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return email.isNotEmpty ? const Home() : LoginPage();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
