import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/utilities/qr_utilities.dart';
import 'package:mobile_voting_verifier/widgets/logo.dart';

class TotpScreen extends StatefulWidget {
  const TotpScreen({super.key, required this.qrData});

  final String qrData;

  @override
  State<StatefulWidget> createState() => _TotpState();
}

class _TotpState extends State<TotpScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    final valid = isValid(widget.qrData);
    final scanParams = valid ? getParameters(widget.qrData) : {};
    //TODO extact to individual widgets
    return Scaffold(
      body: valid //QR code is valid
          ? Center(
              child: isSmallScreen
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Logo(
                          validQr: valid,
                        ),
                        //_FormContent(),
                        Text("c: ${scanParams['c']}"),
                        Text("vid: ${scanParams['vid']}"),
                        Text("nonce: ${scanParams['nonce']}"),
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
        onPressed: () => Navigator.of(context)
            .popUntil((route) => !Navigator.canPop(context)),
        child: const Icon(Icons.keyboard_return_outlined),
      ),
    );
  }
}
