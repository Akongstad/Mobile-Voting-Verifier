import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/shared/current_page_indicator.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuditSuccessScreen extends StatefulWidget {
  const AuditSuccessScreen({super.key});

  @override
  State<AuditSuccessScreen> createState() => _AuditSuccessScreen();
}

class _AuditSuccessScreen extends State<AuditSuccessScreen> {
  bool first = true;

  /*
  TODO:
  electionID should be electionId from SecondDeviceLoginResponse
  voterID should be ballotVoterId from SecondDeviceLoginResponse
  signature should be signatureHex from SecondDeviceInitialMsg 
  fingerprint should be the derived fingerprint from the checkAcknowledgement() in 
    check_acknowledgement.dart
  */

  final electionID = "bfced618-34aa-4b78-ba5b-d21dc04a1a7e";
  final voterID =
      "0205bf2e14496f68c0f86f6b313f210a9393edb083821dcc4f9914cab9c51c9f2e";
  final signature =
      "529f3e8c7d1f0e2c8061526d8e1d8000c24ab60b32b3bda0ce959788483f977fb12da70ccb7ac154a698ef925cf7ca52e142f8eb22d23e5ccd42b63da227230bf886b13211f5c1f618a946a64f8566fd36849b46a156d4a35288204fd7b22e15fcdce8884b5d6e5c69b07ca271332ba14eced079402c735db642b82ae7478fe2efe849d8c50ba11b7d6985486607a54ea42c6394dc2060ac58cfa9c69cc750816dad43fb74d113ab7bc014e619649688fdbf96a29c894fa2cfc5d2bac8b897d0c8dbb3b79e5c17a90913dcb4ba583ea90e706891d38278745c1b4856f88d045c38b840d4fd427291187c250b2ed7bc846fa25440e98d3e9832f2047e52bc5207";
  final fingerprint =
      "91dd5f592932c7c681f20310c801e7ea935f116527b65ce6524f14c6ad2f9dac";

  Future<void> beginSaveToFile(String electionID, String voterID,
      String signature, String fingerprint) async {
    //Show progress indicator
    showDialog(
        context: context,
        builder: (context) {
          return const CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Color.fromRGBO(36, 151, 44, 1)),
            value: null,
          );
        });

    final pdf = await createPDF(electionID, voterID, signature, fingerprint);
    await savePDF(pdf);

    // Delay
    setState(() => Navigator.of(context).pop());
    Future.delayed(
        const Duration(milliseconds: 50),
        () => Navigator.of(context)
            .popUntil((route) => !Navigator.canPop(context)));
  }

  Future<void> savePDF(pw.Document pdf) async {
    if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      await writePDFToFile(dir, pdf);
    }

    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        final dir = Directory('/storage/emulated/0/Download/');
        await writePDFToFile(dir, pdf);
      }
    }
  }

  Future<void> writePDFToFile(Directory dir, pw.Document pdf) async {
    try {
      var file = File('');
      file = File('${dir.path}/verification_receipt.pdf');
      await file.writeAsBytes(await pdf.save());
      await OpenFilex.open('${dir.path}/verification_receipt.pdf');
    } on FileSystemException catch (err) {
      throw ArgumentError(err.message);
    }
  }

  Future<pw.Document> createPDF(String electionID, String voterID,
      String signature, String fingerprint) async {
    final pdf = pw.Document();
    final shortFingerprint = fingerprint.substring(0, 10);

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Project ID: $electionID"),
              pw.Text("Voter ID: $voterID"),
              pw.Text("Ballot Fingerprint: $shortFingerprint"),
              pw.Padding(padding: const pw.EdgeInsets.all(8.0)),
              pw.Text("-----BEGIN FINGERPRINT-----"),
              pw.Text(fingerprint),
              pw.Text("-----END FINGERPRINT-----"),
              pw.Text("-----BEGIN SIGNATURE-----"),
              pw.Text(signature),
              pw.Text("-----END SIGNATURE-----")
            ],
          );
        }));

    return pdf;
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      Future.delayed(const Duration(milliseconds: 50),
          () => setState(() => first = false));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CurrentPageIndicator(
            currentStep: 5,
            failure: false,
          ),
          Expanded(
            child: AnimatedOpacity(
                opacity: first ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 500),
                child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .finalScreenSuccessTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                                color: const Color.fromRGBO(
                                                    36, 151, 44, 1)),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Divider(
                                      height: 20,
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .color,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .finalScreenSuccessToast,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .finalScreenSuccessDescription,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  Padding(padding: const EdgeInsets.all(10.0)),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 35,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: <Color>[
                                              const Color.fromARGB(
                                                  255, 36, 151, 44),
                                              Color.fromARGB(255, 31, 134, 38),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            padding: const EdgeInsets.all(10),
                                            textStyle:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          onPressed: () => Navigator.of(context)
                                              .popUntil((route) =>
                                                  !Navigator.canPop(context)),
                                          /* () => {
                                            beginSaveToFile(electionID, voterID,
                                                signature, fingerprint)
                                          }, */
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .finalScreenSuccessButton),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ]))),
          )
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        backgroundColor: const Color.fromRGBO(151, 36, 46, 1.0),
        child: const Icon(Icons.keyboard_return_outlined),
      ),
    );
  }
}
