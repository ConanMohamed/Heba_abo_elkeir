import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heba_abo_elkheir/screens/home_page.dart';
import 'package:heba_abo_elkheir/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  final onboarding = pref.getBool('onboarding') ?? false;
  runApp(
    ProviderScope(
        child: MyApp(
      onboarding: onboarding,
    )),
  );
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
            primary: const Color.fromRGBO(248, 116, 0, 1),
            seedColor: const Color.fromRGBO(248, 116, 0, 1)),
        useMaterial3: true,
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      home: onboarding ? const Home() : const Welcome(),
      routes: {
        "home": (context) => const Home(),
        "welcome": (context) => const Welcome(),
      },
    );
  }
}
