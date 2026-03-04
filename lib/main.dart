import 'package:flutter/material.dart';
import 'package:machine_test/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
