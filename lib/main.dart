import 'package:flutter/material.dart';
import 'package:proj4_responsive_app/widgets/expenses.dart';
// import 'package:flutter/services.dart';

ColorScheme kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 136, 204, 238));

ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 5, 99, 125),
  brightness: Brightness.dark,
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
            colorScheme: kDarkColorScheme,
            cardTheme: const CardTheme().copyWith(
              color: kDarkColorScheme.secondaryContainer,
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: kDarkColorScheme.primaryContainer,
                foregroundColor: kDarkColorScheme.onPrimaryContainer,
              ),
            )),
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onSecondaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 139, 69, 19),
                  fontSize: 16)),
        ),
        home: const Expenses(),
        themeMode: ThemeMode.system,
      ),
    );
//   });
}