import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/home/view/home_page.dart';
import 'package:mobile_voting_verifier/themes/themes.dart';

/*
* Notes
* Use icons.adaptive to auto fit platform
*/
Future<void> main() async {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      // For testing UI performance
      builder: (context, widget) {
        // Custom error widget for build phase errors
        Widget error = const Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator) {
          error = Scaffold(body: Center(child: error));
        }
        ErrorWidget.builder = (errorDetails) => error;
        if (widget != null) return widget;
        throw ('widget is null');
      },
      title: 'Mobile Vote Verifier',
      theme: appTheme,
      home: const HomePage(),
      themeMode: ThemeMode.light,
    );
  }
}
