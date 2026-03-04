import 'package:flutter/material.dart';
import 'core/utils/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppRoutes.login,

      theme: ThemeData(
        primaryColor: const Color(0xFF7C2F02),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7C2F02),
          foregroundColor: Colors.white,
        ),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C2F02),
          primary: const Color(0xFF7C2F02),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7C2F02),
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
