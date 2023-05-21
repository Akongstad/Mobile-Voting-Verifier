import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_cryptography/local_cryptography.dart';
import 'package:mobile_voting_verifier/audit/view/ballot_audit_page.dart';
import 'package:mobile_voting_verifier/qr_scanner/models/qr_code.dart';
import 'package:mobile_voting_verifier/shared/current_page_indicator.dart';
import 'package:mobile_voting_verifier/welcome/view/welcome_page.dart';
import 'package:mobile_voting_verifier/totp/widgets/TOTPHeaderWidget.dart';
import 'package:mobile_voting_verifier/totp/widgets/logo.dart';
import 'package:mobile_voting_verifier/totp/widgets/pinput_totp_widget.dart';

class TOTPPage extends StatefulWidget {
  const TOTPPage({super.key, required this.valid, required this.qrCode});

  //valid qr-data?
  final bool valid;

  //If valid. Scan params else null
  final QRCode qrCode;

  @override
  State<TOTPPage> createState() => _TOTPPageState();
}

class _TOTPPageState extends State<TOTPPage> {
  bool first = true;
  bool validationProgress = false;

  /// TODO: moving to this page should spawn a thread that uses the
  /// [SecondDeviceLoginResponse] from the post/login request in validate to complete the following:
  /// 1. Integrity of the second device public parameters. verifySecondDeviceParameters in: [VerifiableSecondDeviceParameters]
  /// 2. Check the acknowledgement. [package:local_cryptography/src/spec_logic/check_acknowledgement.dart]
  /// 3. Decrypt the QR-code. [package:local_cryptography/src/spec_logic/decrypt_qr.dart]
  /// 4. Issue Challenge request and the Final Message to gain [SecondDeviceFinalMsg].
  /// 5. Validate the ZKP proof: check whether the zero-knowledge proof exchange should be accepted. [package:local_cryptography/src/spec_logic/validate_zkp.dart]
  /// 6. Decode users choice. [package:local_cryptography/src/spec_logic/decode_vote.dart]
  /// This should be done using a FutureWidget with a circular progress indicator while awaiting the thread.
  /// Thus we can begin the protocols before the user presses the [Go to ballot] button, that return the the [BallotAuditPage]
  Function setPinValidated() => () => {setPinValidatedDelay()};

  void setPinValidatedDelay() {
    Future.delayed(const Duration(milliseconds: 50),
        () => setState(() => validationProgress = true));
    Future.delayed(
        const Duration(milliseconds: 500),
        () =>  Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const WelcomePage())));
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      Future.delayed(const Duration(milliseconds: 50),
          () => setState(() => first = false));
    }

    return Scaffold(
      body: widget.valid //QR code is valid or invalid (true or false)
          ? SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CurrentPageIndicator(
                    currentStep: 2,
                    failure: false,
                  ),
                  Expanded(
                    child: AnimatedOpacity(
                      opacity: first ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 500),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
                        child: Column(
                          children: [
                            const TOTPHeaderWidget(),
                            validationProgress
                                ? CircularProgressIndicator(
                                    color: Color.fromRGBO(151, 36, 46, 1.0),
                                  )
                                : PinputWidget(
                                    qrCode: widget.qrCode,
                                    pinValidated: setPinValidated(),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : SafeArea(
              child: Center(
                child: Logo(
                  validQr: widget.valid,
                ),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .popUntil((route) => !Navigator.canPop(context)),
        backgroundColor: const Color.fromRGBO(151, 36, 46, 1.0),
        child: const Icon(Icons.keyboard_return_outlined),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
