import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/shared/current_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class AuditFailureScreen extends StatefulWidget {
  const AuditFailureScreen({super.key});

  @override
  State<AuditFailureScreen> createState() => _AuditFailureScreen();
}

class _AuditFailureScreen extends State<AuditFailureScreen> {
  bool first = true;

  @override
  Widget build(BuildContext context) {
    if (first) {
      Future.delayed(const Duration(milliseconds: 50),
          () => setState(() => first = false));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CurrentPageIndicator(
            currentStep: 5,
            failure: true,
          ),
          Expanded(
            child: AnimatedOpacity(
                opacity: first ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 500),
                child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Report a problem",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                                color: const Color.fromRGBO(
                                                    151, 36, 46, 1.0)),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Divider(
                                      height: 20,
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .color,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                        "Do you believe that your vote has been recorded incorrectly? You can contact the election administrators.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      "Press continue to proceed to the support section of the official election website.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  Padding(padding: const EdgeInsets.all(10.0)),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 35,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: <Color>[
                                              Color.fromRGBO(151, 36, 46, 1.0),
                                              Color.fromRGBO(126, 40, 83, 1),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.all(10),
                                            textStyle:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          onPressed: () async => await canLaunchUrl(Uri(
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
                                          child: const Text('Continue'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ]))),
          )
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        backgroundColor: const Color.fromRGBO(151, 36, 46, 1.0),
        child: const Icon(Icons.keyboard_return_outlined),
      ),
    );
  }
}
