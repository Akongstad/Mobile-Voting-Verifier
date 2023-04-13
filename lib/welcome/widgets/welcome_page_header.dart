import 'package:flutter/material.dart';

class WelcomePageHeader extends StatelessWidget {
  const WelcomePageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Welcome!',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 24),
        Text(
          "Press the 'Audit ballot' button to display your recorded vote.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32)
      ],
    );
  }
}
