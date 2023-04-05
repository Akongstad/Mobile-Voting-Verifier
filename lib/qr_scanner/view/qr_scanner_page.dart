import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mobile_voting_verifier/qr_scanner/models/qr_code.dart';
import 'package:mobile_voting_verifier/shared/current_page_indicator.dart';
import 'package:mobile_voting_verifier/totp/view/totp_page.dart';
import 'package:mobile_voting_verifier/qr_scanner/widgets/qr_scanner_overlay.dart';

//Page with qr-scanner
class QrScannerPage extends StatelessWidget {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(children: [
        MobileScanner(
            allowDuplicates: false,
            onDetect: (barcode, args) => _onDetectBarcode(context, barcode, args)),
        QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.1)),
        Padding(
            padding: MediaQuery.of(context).padding,
            child: const CurrentPageIndicator(currentStep: 1,))
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'cancel',
        onPressed: () {
          //Production
          Navigator.pop(context);

          //Development using emulator:
          //TODO change before push
          /*Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ScanValidationScreen(qrData: "")));*/
        },
        backgroundColor: Colors.white,
        splashColor: Colors.grey,
        child: const Icon(
          Icons.cancel_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}
void _onDetectBarcode(BuildContext context, Barcode barcode, MobileScannerArguments? mobileScannerArguments){
  try {
    if (barcode.rawValue == null) {
      debugPrint('Failed to scan Barcode');
    } else {
      final String code = barcode.rawValue!;
      log('Barcode found! $code');
      final isValid = QRCode.isValid(code);
      final qrCode = QRCode.fromString(code);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ScanValidationScreen(
                  valid: isValid,
                  qrCode: qrCode)));
    }
  } on ArgumentError catch (e) {
    log(e.toString());
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>  ScanValidationScreen(
            valid: false, qrCode: QRCode(c: "", vid: "", nonce: ""))));
  }
}
