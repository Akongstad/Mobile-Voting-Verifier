import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mobile_voting_verifier/screens/scan_validation_screen.dart';
import 'package:mobile_voting_verifier/widgets/qr_scanner_overlay.dart';
//Page with qr-scanner
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
        children:[ MobileScanner( //TODO Disable Multiple QR code Scans.
          allowDuplicates: false,
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;
              debugPrint('Barcode found! $code');
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ScanValidationScreen(qrData: code)));
            }
          }),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.1))
        ]
      ),
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
        child: const Icon(Icons.cancel_outlined, color: Colors.black,),
      ),
    );
  }
}