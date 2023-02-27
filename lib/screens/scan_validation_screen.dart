import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/widgets/TOTPHeaderWidget.dart';
import 'package:mobile_voting_verifier/widgets/logo.dart';
import 'package:mobile_voting_verifier/widgets/pinput_totp_widget.dart';

class ScanValidationScreen extends StatefulWidget {
   const ScanValidationScreen({super.key, required this.valid, required this.scanParams});

   //valid qr-data?
   final bool valid;
   //If valid. Scan params else null
   final Map<String, String>? scanParams;

  @override
  State<ScanValidationScreen> createState() => _ScanValidationScreenState();
}

class _ScanValidationScreenState extends State<ScanValidationScreen> {
  bool first = true;//Show checkmark widget
  @override
  Widget build(BuildContext context) {
    //Init crossfade animation
    if (first) Future.delayed(const Duration(seconds: 2), () =>  setState(() => first = false));
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    //TODO extract to individual widgets
    return Scaffold(
      body: widget.valid //QR code is valid
          ? Center(
              child: isSmallScreen
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedCrossFade(
                          firstChild: Logo(validQr: widget.valid),
                          crossFadeState: first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 200),
                          secondChild: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
                            child: Column(
                              children: [
                                const TOTPHeaderWidget(),
                                PinputWidget(scanParams: widget.scanParams!),
                                //_FormContent(),
                              ],
                            ),
                          ),
                        )
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
                    ))
          : Center(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).popUntil((route) => !Navigator.canPop(context)),
        child: const Icon(Icons.keyboard_return_outlined),
      ),
    );
  }
}
