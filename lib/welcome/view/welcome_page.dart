import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/audit/view/ballot_audit_page.dart';
import 'package:mobile_voting_verifier/shared/current_page_indicator.dart';
import 'package:mobile_voting_verifier/welcome/widgets/welcome_page_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  bool first = true;
  final List<TextButton> items = [];

  /// A future that will complete after 2 seconds.
  /// Simulates:
  /// 1. Integrity of the second device public parameters. verifySecondDeviceParameters in: [VerifiableSecondDeviceParameters]
  /// 2. Check the acknowledgement. [package:local_cryptography/src/spec_logic/check_acknowledgement.dart]
  /// 3. Decrypt the QR-code. [package:local_cryptography/src/spec_logic/decrypt_qr.dart]
  /// 4. Issue Challenge request and the Final Message to gain [SecondDeviceFinalMsg].
  /// 5. Validate the ZKP proof: check whether the zero-knowledge proof exchange should be accepted. [package:local_cryptography/src/spec_logic/validate_zkp.dart]
  /// 6. Decode users choice. [package:local_cryptography/src/spec_logic/decode_vote.dart]
  Future<Widget> _calculation(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color.fromRGBO(151, 36, 46, 1.0),
                    Color.fromRGBO(126, 40, 83, 1),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16.0),
              textStyle: const TextStyle(fontSize: 15),
            ),

            /// TODO: Inject the decoded choice into the ballot audit page.
            onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BallotAuditPage())),
            },
            child: Text(AppLocalizations.of(context)!.auditBallotButton),
          ),
        ],
      ),
    );
  }

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
            currentStep: 3,
            failure: false,
          ),
          Expanded(
            child: AnimatedOpacity(
              opacity: first ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 500),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const WelcomePageHeader(),
                    const SizedBox(height: 30),
                    FutureBuilder<Widget>(
                      future: _calculation(context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data!;
                        } else if (snapshot.hasError) {
                          /// Abort the process and return to the home page.
                          return Text(
                              'Failed cryptographic protocol: ${snapshot.error}');
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppLocalizations.of(context)!.welcomeScreenProgress),
                            const SizedBox(height: 20),
                            CircularProgressIndicator(
                              color: Color.fromRGBO(151, 36, 46, 1.0),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
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
