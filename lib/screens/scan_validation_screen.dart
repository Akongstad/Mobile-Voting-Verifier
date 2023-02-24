import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/utilities/qr_utilities.dart';
import 'package:mobile_voting_verifier/widgets/TOTPHeaderWidget.dart';
import 'package:mobile_voting_verifier/widgets/logo.dart';
import 'package:mobile_voting_verifier/widgets/pinput_totp_widget.dart';

class ScanValidationScreen extends StatelessWidget {
  const ScanValidationScreen({super.key, required this.qrData});

  final String qrData;

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    final valid = isValid(qrData);
    final scanParams = valid ? getParameters(qrData) : {"":""};
    /*Future.delayed(const Duration(seconds: 1), () {
      //TODO uncomment for production
      if (valid){
        print("called");
        Navigator.push(context, MaterialPageRoute(builder: (context) => TOTPScreen(PinputWidget(scanParams: scanParams))));
      }
      //Development:
      *//*Navigator.push(context, MaterialPageRoute(builder: (context) => TOTPScreen(PinputWidget(scanParams: scanParams))));*//*
    });*/
    //TODO extract to individual widgets
    return Scaffold(
      body: valid //QR code is valid
          ? Center(
              child: isSmallScreen ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Logo(
                          validQr: valid
                        ),
                        //_FormContent(),
                        SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
                          child: Column(
                            children: [
                              const TOTPHeaderWidget(),
                              PinputWidget(scanParams: scanParams),
                            ],
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
                            child: Logo(validQr: valid),
                          ),

                          //Expanded(
                          //child: Center(child: _FormContent()),
                          //),
                        ],
                      ),
                    ))
          : Center( //QR code isInvalid
              child: isSmallScreen
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Logo(
                          validQr: valid,
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.all(32.0),
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Row(
                        children: [
                          Expanded(
                            child: Logo(validQr: valid),
                          ),
                        ],
                      ),
                    )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Icon(Icons.keyboard_return_outlined),
      ),
    );
  }
}
