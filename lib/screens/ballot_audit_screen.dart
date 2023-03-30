import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/models/verifiable_second_device_parameters.dart';
import 'package:mobile_voting_verifier/widgets/BallotAuditWidgets/ballot_display_widget.dart';
import 'package:mobile_voting_verifier/widgets/BallotAuditWidgets/bottom_modal_report.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:mobile_voting_verifier/widgets/current_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class BallotAuditScreen extends StatefulWidget {
  const BallotAuditScreen({super.key});

  @override
  State<BallotAuditScreen> createState() => _BallotAuditScreen();
}

class _BallotAuditScreen extends State<BallotAuditScreen> {
  bool first = true;
  int currentStep = 4;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               CurrentPageIndicator(
                currentStep: currentStep,
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
                        Text(
                          'Your ballot was recorded',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  color: const Color.fromRGBO(36, 151, 44, 1)),
                        ),
                        Divider(
                          height: 20,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                        ),
                        const Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(vertical: 8.0)),
                        Text('You can no longer change your ballot.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.black),
                            textAlign: TextAlign.center),
                        const Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                vertical: 10.0)),
                        FutureBuilder(
                          future: VerifiableSecondDeviceParameters.jsonFromFile(
                              "assets/mock_ballot_spec.json"),
                          //TODO Dont switch to fetched data
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              final ballotSpecs =
                                  VerifiableSecondDeviceParameters.fromJson(
                                          snapshot.data["publicParametersJson"])
                                      .ballots;
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: ballotSpecs.length,
                                itemBuilder: (context, index) {
                                  return BallotDisplayWidget(
                                    ballotSpec: ballotSpecs[index],
                                  );
                                },
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                        const Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                vertical: 10.0)),
                        const Text(
                            'Use the download button to receive an encrypted receipt that can be used to ensure that your ballot is included in the final tally.',
                            textAlign: TextAlign.center),
                        const Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                vertical: 10.0)),
                        const Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(vertical: 5.0)),
                        Container(
                          height: 35,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color.fromRGBO(151, 36, 46, 1.0),
                                Color.fromRGBO(126, 40, 83, 1),
                              ],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(10),
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (context) => const BottomModalReport(),
                            ),
                            child: const Text('Report a problem'),
                          ),
                        ),
                        const Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(vertical: 8.0)),
                        const Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(vertical: 8.0)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                  onPressed: () => Navigator.of(context)
                      .popUntil((route) => !Navigator.canPop(context)),
                  backgroundColor: const Color.fromRGBO(151, 36, 46, 1.0),
                  child: const Icon(Icons.keyboard_return_outlined)),
              FloatingActionButton(
                onPressed: () => {beginSaveToFile(
                    electionID, voterID, signature, fingerprint),
                  setState(() => currentStep = 5)
                },
                backgroundColor: const Color.fromARGB(255, 36, 151, 44),
                heroTag: false,
                child: const Icon(Icons.file_download),
              )
            ],
          ),
        ));
  }
}
