import 'package:flutter/material.dart';
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
      showPerformanceOverlay: true,
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
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.grey[200],
        navigationBarTheme: const NavigationBarThemeData(
        )
      ),
      themeMode: ThemeMode.dark,
      home: const Catalog(),
    );
  }
}
