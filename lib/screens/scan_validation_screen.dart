import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/models/qr_code.dart';
import 'package:mobile_voting_verifier/screens/ballot_audit_screen.dart';
import 'package:mobile_voting_verifier/widgets/TOTPHeaderWidget.dart';
import 'package:mobile_voting_verifier/widgets/logo.dart';
import 'package:mobile_voting_verifier/widgets/pinput_totp_widget.dart';

class ScanValidationScreen extends StatefulWidget {
  const ScanValidationScreen(
      {super.key, required this.valid, required this.qrCode});

  //valid qr-data?
  final bool valid;
  //If valid. Scan params else null
  final QRCode qrCode;

  @override
  State<ScanValidationScreen> createState() => _ScanValidationScreenState();
}

bool pinValidated = false;

class _ScanValidationScreenState extends State<ScanValidationScreen> {
  bool first = true; //Show checkmark widget

  @override
  Widget build(BuildContext context) {
    //Init crossfade animation
    if (first) {
      Future.delayed(
          const Duration(seconds: 2), () => setState(() => first = false));
    }
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      body: widget.valid //QR code is valid
          ? SafeArea(
              child: Center(
                  child: isSmallScreen
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedCrossFade(
                              firstChild: Logo(validQr: widget.valid),
                              crossFadeState: first
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              duration: const Duration(milliseconds: 300),
                              secondChild: AnimatedCrossFade(
                                firstChild: SingleChildScrollView(
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 64, 24, 24),
                                  child: Column(
                                    children: [
                                      const TOTPHeaderWidget(),
                                      PinputWidget(qrCode: widget.qrCode),
                                    ],
                                  ),
                                ),
                                crossFadeState: !pinValidated
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                duration: const Duration(milliseconds: 300),
                                secondChild: const SingleChildScrollView(
                                    padding:
                                        EdgeInsets.fromLTRB(24, 64, 24, 24),
                                    child: BallotAuditScreen()),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(32.0),
                          constraints: const BoxConstraints(maxWidth: 800),
                          child: Row(
                            children: [
                              Expanded(
                                child: Logo(validQr: widget.valid),
                              ),

                              //Expanded(
                              //child: Center(child: _FormContent()),
                              //),
                            ],
                          ),
                        )),
            )
          : SafeArea(
              child: Center(
                  //QR code isInvalid
                  child: isSmallScreen
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Logo(
                              validQr: widget.valid,
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(32.0),
                          constraints: const BoxConstraints(maxWidth: 800),
                          child: Row(
                            children: [
                              Expanded(
                                child: Logo(validQr: widget.valid),
                              ),
                            ],
                          ),
                        )),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => actionButtonHelper(context),
        backgroundColor: const Color.fromRGBO(151, 36, 46, 1.0),
        child: const Icon(Icons.keyboard_return_outlined),
      ),
    );
  }
}

void actionButtonHelper(BuildContext context) {
  pinValidated = false;
  Navigator.of(context).popUntil((route) => !Navigator.canPop(context));
}
