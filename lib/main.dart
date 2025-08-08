import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'presentation/pages/splash_page.dart';
import 'presentation/theme/light_theme.dart';
import 'presentation/theme/dark_theme.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const QuickNewsApp());
}

class QuickNewsApp extends StatelessWidget {
  const QuickNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick News',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashPage(),
    );
  }
}