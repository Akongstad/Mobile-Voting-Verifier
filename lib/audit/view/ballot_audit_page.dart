import 'package:flutter/material.dart';
import 'package:local_cryptography/local_cryptography.dart';
import 'package:mobile_voting_verifier/audit/widgets/ballot_display_widget.dart';
import 'package:mobile_voting_verifier/final_failure/view/final_failure_page.dart';
import 'package:mobile_voting_verifier/final_success/final_success.dart';
import 'package:mobile_voting_verifier/shared/current_page_indicator.dart';

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
                        'Your ballot was recorded',
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
                      Text(
                          'Please verify that ballot below matches your choice.\n'
                          'You can no longer change your ballot.',
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
                          text:
                              'If your ballot matches your choice you can continue using the ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'green',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 36, 151, 44))),
                            TextSpan(text: ' button.'),
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
                              text:
                                  'If your have encountered an issue with your ballot. Please, continue using the ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black),
                              children: <TextSpan>[
                            TextSpan(
                                text: 'red',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(151, 36, 46, 1.0))),
                            TextSpan(text: ' button.')
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
                      /* Container(
                          height: 35,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color.fromRGBO(151, 36, 46, 1.0),
                                Color.fromRGBO(126, 40, 83, 1),
                              ],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(10),
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (context) => const BottomModalReport(),
                            ),
                            child: const Text('Report a problem'),
                          ),
                        ), */
                      /* const Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(vertical: 8.0)),
                      const Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(vertical: 8.0)), */
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
