import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:mobile_voting_verifier/widgets/current_page_indicator.dart';

class BallotAuditScreen extends StatefulWidget {
  const BallotAuditScreen({super.key});

  @override
  State<BallotAuditScreen> createState() => _BallotAuditScreen();
}

class _BallotAuditScreen extends State<BallotAuditScreen> {
  bool first = true;

  Future<void> saveFile(String fileName) async {
    var file = File('');
    final byteData = await rootBundle.load('assets/$fileName');

    if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/$fileName');
      await writeToFile(file, byteData);
      await OpenFilex.open('${dir.path}/$fileName');
    }

    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        const downloadsFolderPath = '/storage/emulated/0/Download/';
        Directory dir = Directory(downloadsFolderPath);
        file = File('${dir.path}/$fileName');
        await writeToFile(file, byteData);
        await OpenFilex.open('${dir.path}/$fileName');
      }
    }
  }

  Future<void> writeToFile(File file, ByteData byteData) async {
    try {
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    } on FileSystemException catch (err) {
      throw ArgumentError(err.message);
    }
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
              const CurrentPageIndicator(
                currentStep: 4,
              ),
              Expanded(
                child: AnimatedOpacity(
                  opacity: first ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: const SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(24, 64, 24, 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 100,
                          color: Color.fromRGBO(0, 128, 64, 1.0),
                        ),
                        Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(vertical: 2.0)),
                        Text('Your ballot has been validated',
                            style: TextStyle(
                                fontSize: 28,
                                color: Color.fromRGBO(0, 128, 64, 1.0)),
                            textAlign: TextAlign.center),
                        Padding(
                            padding:
                                EdgeInsetsDirectional.symmetric(vertical: 8.0)),
                        Text(
                            'Please note that the following is an image of your ballot or ballots in the ballot box.',
                            textAlign: TextAlign.center),
                        Text('You can no longer change your ballot.',
                            textAlign: TextAlign.center),
                        Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                vertical: 8.0)), //TODO: INSERT BALLOT HERE
                        Text(
                            'If the recorded vote is different from the vote you intended, please contact 12-345-678',
                            textAlign: TextAlign.center),
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
                onPressed: () => saveFile('fingerprint.txt'),
                backgroundColor: const Color.fromARGB(255, 36, 151, 44),
                child: const Icon(Icons.navigate_next),
              )
            ],
          ),
        ));
  }
}
