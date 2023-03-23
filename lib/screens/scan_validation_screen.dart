import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/models/qr_code.dart';
import 'package:mobile_voting_verifier/screens/welcome_page.dart';
import 'package:mobile_voting_verifier/widgets/TOTPHeaderWidget.dart';
import 'package:mobile_voting_verifier/widgets/current_page_indicator.dart';
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

class _ScanValidationScreenState extends State<ScanValidationScreen> {
  bool first = true;

  Function setPinValidated() => () => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const WelcomePage()));

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
                            PinputWidget(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Logo(
                    validQr: widget.valid,
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
      resizeToAvoidBottomInset: false,
    );
  }
}
