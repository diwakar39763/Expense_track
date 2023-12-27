import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 94, 38, 226),
);

var kDarkScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDarkScheme.primaryContainer)),
                 cardTheme: const CardTheme().copyWith(
            color: kDarkScheme.onSecondary,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
            
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.onPrimary,
          elevation: 23,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primaryContainer)),
        cardTheme: const CardTheme().copyWith(
            color: kColorScheme.onSecondary,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16)),
      ),
      home: const Expenses(),
    ),
  );
}
