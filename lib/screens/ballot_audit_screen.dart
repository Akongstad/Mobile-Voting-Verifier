import 'package:flutter/material.dart';

class BallotAuditScreen extends StatefulWidget {
  const BallotAuditScreen({super.key});

  @override
  State<BallotAuditScreen> createState() => _BallotAuditScreen();
}

class _BallotAuditScreen extends State<BallotAuditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsetsDirectional.all(20.0)),
            const Icon(
              Icons.check_circle,
              size: 100,
              color: Color.fromRGBO(0, 128, 64, 1.0),
            ),
            const Padding(padding: EdgeInsetsDirectional.all(2.0)),
            const Text('Your ballot was successfully verified',
                style: TextStyle(
                    fontSize: 28, color: Color.fromRGBO(0, 128, 64, 1.0)),
                textAlign: TextAlign.center),
            const Padding(padding: EdgeInsetsDirectional.all(8.0)),
            const Text(
                'Please note that the following is an image of your ballot or ballots in the ballot box.',
                textAlign: TextAlign.center),
            const Text('You can no longer change your ballot.',
                textAlign: TextAlign.center),
            const Padding(padding: EdgeInsetsDirectional.all(20.0)),
            Image.network(
              "https://img.freepik.com/premium-vector/ballot-icon-hand-drawn-sketch_755164-9091.jpg",
              height: 200,
              width: 200,
              cacheHeight: 200,
              cacheWidth: 200,
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
