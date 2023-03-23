import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/models/verifiable_second_device_parameters.dart';
import 'package:mobile_voting_verifier/widgets/BallotAuditWidgets/ballot_display_widget.dart';
import 'package:mobile_voting_verifier/widgets/current_page_indicator.dart';

class BallotAuditScreen extends StatefulWidget {
  const BallotAuditScreen({super.key});

  @override
  State<BallotAuditScreen> createState() => _BallotAuditScreen();
}

class _BallotAuditScreen extends State<BallotAuditScreen> {
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
            const CurrentPageIndicator(
              currentStep: 4,
            ),
            Expanded(
              child: AnimatedOpacity(
                opacity: first ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 500),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 100,
                        color: Color.fromRGBO(0, 128, 64, 1.0),
                      ),
                      const Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(vertical: 2.0)),
                      const Text('Your ballot has been validated',
                          style: TextStyle(
                              fontSize: 28,
                              color: Color.fromRGBO(0, 128, 64, 1.0)),
                          textAlign: TextAlign.center),
                      const Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(vertical: 8.0)),
                      const Text(
                          'Please note that the following is an image of your ballot or ballots in the ballot box.',
                          textAlign: TextAlign.center),
                      const Text('You can no longer change your ballot.',
                          textAlign: TextAlign.center),
                      const Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              vertical: 8.0)), //TODO: INSERT BALLOT HERE
                      const Text(
                          'If the recorded vote is different from the vote you intended, please contact 12-345-678',
                          textAlign: TextAlign.center),
                      FutureBuilder(
                        future: VerifiableSecondDeviceParameters.jsonFromFile("assets/mock_ballot_spec.json"), //TODO Dont switch to fetched data
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            final ballotSpecs = VerifiableSecondDeviceParameters.fromJson(snapshot.data["publicParametersJson"]).ballots;
                            return ListView.builder(
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

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .popUntil((route) => !Navigator.canPop(context)),
        backgroundColor: const Color.fromRGBO(151, 36, 46, 1.0),
        child: const Icon(Icons.keyboard_return_outlined),
      ),
    );
  }
}
