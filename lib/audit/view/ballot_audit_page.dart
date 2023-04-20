import 'package:flutter/material.dart';
import 'package:local_cryptography/local_cryptography.dart';
import 'package:mobile_voting_verifier/audit/widgets/ballot_display_widget.dart';
import 'package:mobile_voting_verifier/final_failure/view/final_failure_page.dart';
import 'package:mobile_voting_verifier/final_success/final_success.dart';
import 'package:mobile_voting_verifier/shared/current_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BallotAuditPage extends StatefulWidget {
  const BallotAuditPage({super.key});

  @override
  State<BallotAuditPage> createState() => _BallotAuditScreen();
}

class _BallotAuditScreen extends State<BallotAuditPage> {
  bool first = true;

  @override
  Widget build(BuildContext context) {
    if (first) {
      Future.delayed(const Duration(milliseconds: 50),
          () => setState(() => first = false));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CurrentPageIndicator(
              currentStep: 4,
              failure: false,
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
                      Text(
                        AppLocalizations.of(context)!.auditScreenTitle,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: const Color.fromRGBO(36, 151, 44, 1)),
                      ),
                      Divider(
                        height: 20,
                        color: Theme.of(context).textTheme.displayLarge!.color,
                      ),
                      const Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(vertical: 8.0)),
                      Text(AppLocalizations.of(context)!.auditScreenDescription,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black),
                          textAlign: TextAlign.center),
                      const Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(vertical: 10.0)),
                      FutureBuilder(
                        future: VerifiableSecondDeviceParameters.jsonFromFile(
                            "assets/mock_ballot_spec.json"),
                        //TODO Dont switch to fetched data
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            final ballotSpecs =
                                VerifiableSecondDeviceParameters.fromJson(
                                        snapshot.data["publicParametersJson"])
                                    .ballots;
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: ballotSpecs.length,
                              itemBuilder: (context, index) {
                                return BallotDisplayWidget(
                                  ballotSpec: ballotSpecs[index],
                                );
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      const Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(vertical: 10.0)),
                      /* const Text(
                          'If you ballot matches your choice you can continue using the green button.',
                          textAlign: TextAlign.center), */
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!
                              .auditScreenTextSuccess,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: AppLocalizations.of(context)!
                                    .auditScreenTextGreen,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 36, 151, 44))),
                            TextSpan(
                                text: AppLocalizations.of(context)!
                                    .auditScreenTextButton),
                          ],
                        ),
                      ),
                      const Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(vertical: 10.0)),
                      /* const Text(
                          'If you have encountered an issue with your ballot. Please, continue using the red button.',
                          textAlign: TextAlign.center), */
                      RichText(
                          text: TextSpan(
                              text: AppLocalizations.of(context)!
                                  .auditScreenTextFailure,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black),
                              children: <TextSpan>[
                            TextSpan(
                                text: AppLocalizations.of(context)!
                                    .auditScreenTextRed,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(151, 36, 46, 1.0))),
                            TextSpan(
                                text: AppLocalizations.of(context)!
                                    .auditScreenTextButton)
                          ])),
                      const Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(vertical: 5.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(
                              onPressed: () => {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AuditFailureScreen())),
                                  },
                              backgroundColor:
                                  const Color.fromRGBO(151, 36, 46, 1.0),
                              child: const Icon(Icons.close)),
                          Padding(padding: EdgeInsets.all(50.0)),
                          FloatingActionButton(
                            onPressed: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AuditSuccessScreen())),
                            },
                            backgroundColor:
                                const Color.fromARGB(255, 36, 151, 44),
                            heroTag: false,
                            child: const Icon(Icons.done),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      /* floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .popUntil((route) => !Navigator.canPop(context)),
        backgroundColor: const Color.fromRGBO(151, 36, 46, 1.0),
        child: const Icon(Icons.keyboard_return_outlined),
      ), */
    );
  }
}
