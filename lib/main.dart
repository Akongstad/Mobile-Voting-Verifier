import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_voting_verifier/screens/catalog.dart';
/*
* Notes
* Use icons.adaptive to auto fit platform
*/
Future<void> main() async {
  /*await myErrorsHandler.initialize();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    myErrorsHandler.onErrorDetails(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    myErrorsHandler.onError(error, stack);
    return true;
  };*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false, // For testing UI performance
      builder: (context, widget) { // Custom error widget for build phase errors
        Widget error = const Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator) {
          error = Scaffold(body: Center(child: error));
        }
        ErrorWidget.builder = (errorDetails) => error;
        if (widget != null) return widget;
        throw ('widget is null');
      },
      title: 'Mobile Vote Verifier',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(244, 245, 247, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color.fromRGBO(151, 36, 46, 1.0),
          elevation: 0,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromRGBO(151, 36, 46, 1.0),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(47, 67, 80,1),
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(30, 60, 87, 1),
          ),
          bodyLarge: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(47, 67, 80,1),
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 16,
            color: const Color.fromRGBO(133, 153, 170, 1),
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),

        ),
      ),
      themeMode: ThemeMode.light,
      home: const Catalog(),
    );

  }
}
