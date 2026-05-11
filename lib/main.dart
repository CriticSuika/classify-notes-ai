import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:software_studio_project/theme.dart';
import 'package:software_studio_project/template.dart';
import 'package:software_studio_project/service/service_authentication.dart';
import 'package:software_studio_project/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: MaterialTheme.darkScheme(),
          cardTheme: const CardTheme().copyWith(
            color: MaterialTheme.darkScheme().secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: MaterialTheme.darkScheme().primaryContainer,
              foregroundColor: MaterialTheme.darkScheme().onPrimaryContainer,
            ),
          ),
        ),
        theme: ThemeData().copyWith(
          colorScheme: MaterialTheme.lightScheme(),
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: MaterialTheme.lightScheme().onPrimaryContainer,
            foregroundColor: MaterialTheme.lightScheme().primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: MaterialTheme.lightScheme().secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: MaterialTheme.lightScheme().primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MaterialTheme.lightScheme().onSecondaryContainer,
                  fontSize: 16,
                ),
              ),
        ),
        home: const Template());
  }
}
