import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomModalReport extends StatelessWidget {
  const BottomModalReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                  10.0),
              child: Text("Report a problem",
                  style: Theme
                      .of(context)
                      .textTheme
                      .displayMedium),
            ),
            Padding(
              padding: const EdgeInsets
                  .symmetric(
                  horizontal: 20.0),
              child: Divider(
                height: 20,
                color: Theme
                    .of(context)
                    .textTheme
                    .displayLarge!
                    .color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                  20.0),
              child: Text(
                  "Do you believe that your vote has been recorded incorrectly? You can contact the election administrators.",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium),
            ),
            Padding(
              padding: const EdgeInsets.all(
                  20.0),
              child: Text(
                "Press continue to proceed to the support section of the official election website.",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium,
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () =>
                      Navigator.of(context)
                          .pop(),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async =>
                  await canLaunchUrl(Uri(
                      scheme: "https",
                      host: "github.com",
                      path:
                      "Akongstad/Mobile-Voting-Verifier"))
                      ? await launchUrl(Uri(
                      scheme: "https",
                      host: "github.com",
                      path:
                      "Akongstad/Mobile-Voting-Verifier"))
                      : debugPrint(
                      "Could not launch url"),
                  child: const Text("Continue"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
