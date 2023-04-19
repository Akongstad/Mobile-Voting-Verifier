import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePageHeader extends StatelessWidget {
  const WelcomePageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.welcomeHeaderTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 24),
        Text(
          AppLocalizations.of(context)!.welcomeHeaderDescription,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32)
      ],
    );
  }
}
