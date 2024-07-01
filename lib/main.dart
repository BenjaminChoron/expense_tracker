import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.green,
);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primary,
          foregroundColor: kColorScheme.onPrimary,
          titleTextStyle: const TextStyle(
            fontSize: 24,
          ),
        ),
        scaffoldBackgroundColor: kColorScheme.secondaryContainer,
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.onPrimary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primary,
            foregroundColor: kColorScheme.onPrimary,
          ),
        ),
      ),
      home: const Expenses(),
    );
  }
}
