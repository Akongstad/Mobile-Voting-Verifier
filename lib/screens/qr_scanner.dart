import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mobile_voting_verifier/widgets/qr_scanner_overlay.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[ MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;
              debugPrint('Barcode found! $code');
            }
          }),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.1))
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'cancel',
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.white,
        splashColor: Colors.grey,
        child: const Icon(Icons.cancel_outlined, color: Colors.black,),
      ),
    );
  }
}