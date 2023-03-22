import 'package:flutter/material.dart';

class BallotAuditScreen extends StatefulWidget {
  const BallotAuditScreen({super.key});

  @override
  State<BallotAuditScreen> createState() => _BallotAuditScreen();
}

class _BallotAuditScreen extends State<BallotAuditScreen> {
  bool first = true;

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
            AnimatedOpacity(
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
                    Padding(padding: EdgeInsetsDirectional.all(2.0)),
                    Text('Your ballot has been validated',
                        style: TextStyle(
                            fontSize: 28,
                            color: Color.fromRGBO(0, 128, 64, 1.0)),
                        textAlign: TextAlign.center),
                    Padding(padding: EdgeInsetsDirectional.all(8.0)),
                    Text(
                        'Please note that the following is an image of your ballot or ballots in the ballot box.',
                        textAlign: TextAlign.center),
                    Text('You can no longer change your ballot.',
                        textAlign: TextAlign.center),
                    Padding(
                        padding: EdgeInsetsDirectional.all(
                            20.0)), //TODO: INSERT BALLOT HERE
                  ],
                ),
              ),
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
    );
  }
}
