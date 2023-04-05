//Inspiration: https://www.fluttertemplates.dev/widgets/forms/sign_in#responsive_sign_in
import 'package:flutter/material.dart';
class Logo extends StatelessWidget {
  const Logo({Key? key, required this.validQr}) : super(key: key);
  final bool validQr;
  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          validQr ? Icons.check_outlined : Icons.cancel,
          size: isSmallScreen ? 100 : 200,
          color: validQr ? Colors.lightGreen : Colors.redAccent,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            validQr ? "Successfully scanned QR-code" : "Invalid QR-Code",
            textAlign: TextAlign.center,
            style: isSmallScreen ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}