import 'package:flutter/material.dart';

class BallotAuditScreen extends StatefulWidget {
  const BallotAuditScreen({super.key});

  @override
  State<BallotAuditScreen> createState() => _BallotAuditScreen();
}

class _BallotAuditScreen extends State<BallotAuditScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle,
          size: 100,
          color: Color.fromRGBO(0, 128, 64, 1.0),
        ),
        Padding(padding: EdgeInsetsDirectional.all(2.0)),
        Text('Your ballot was successfully verified',
            style:
                TextStyle(fontSize: 28, color: Color.fromRGBO(0, 128, 64, 1.0)),
            textAlign: TextAlign.center),
        Padding(padding: EdgeInsetsDirectional.all(8.0)),
        Text(
            'Please note that the following is an image of your ballot or ballots in the ballot box.',
            textAlign: TextAlign.center),
        Text('You can no longer change your ballot.',
            textAlign: TextAlign.center),
        Padding(padding: EdgeInsetsDirectional.all(8.0)),
        Image(image: AssetImage('assets/mock_ballot.png')),
      ],
    );
  }
}
