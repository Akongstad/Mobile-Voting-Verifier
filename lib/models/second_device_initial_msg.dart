import 'dart:typed_data';
import 'package:mobile_voting_verifier/models/ballot.dart';

class SecondDeviceInitialMsg<G> {
  final Ballot<G> ballot;
  final Uint8List comSeed;
  final List<G> factorA;
  final List<G> factorB;
  final List<G> factorX;
  final List<G> factorY;
  final G publicCredential;
  final String secondDeviceParametersJson; //TODO: as JSON
  final String signatureHex;

  SecondDeviceInitialMsg({
    required this.ballot,
    required this.comSeed,
    required this.factorA,
    required this.factorB,
    required this.factorX,
    required this.factorY,
    required this.publicCredential,
    required this.secondDeviceParametersJson,
    required this.signatureHex,
  });
}
