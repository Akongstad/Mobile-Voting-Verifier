import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_voting_verifier/models/challenge_request.dart';
import 'package:mobile_voting_verifier/models/response_bean.dart';
import 'package:mobile_voting_verifier/models/second_device_final_msg.dart';
import 'package:mobile_voting_verifier/repositories/post_challenge_request.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_challenge_request_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('postChallengeRequest', () {
    test('returns ResponseBean OK if the http call completes successfully',
        () async {
      final client = MockClient();

      ChallengeRequest challengeRequest = ChallengeRequest(
          challenge: BigInt.parse('111222333444555666777888'),
          challengeRandomCoin: BigInt.parse('999999900000008888888001'));
      String authToken = 'dm90ZXJB.Z21jczRLSVVXQTdCblh2eg==';

      when(client.post(
        Uri.parse('/rest/challenge'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'AuthToken': 'dm90ZXJB.Z21jczRLSVVXQTdCblh2eg==',
        },
        body: challengeRequest.toJson(),
      )).thenAnswer((_) async => http.Response(
          '{"value": {"z" : ["3633826251616834446657553661530373736489206587264246793596555854504147120873052400272122845815239659486740186516083053240689380"]}, "status" : "OK"}',
          200));

      var actual = await createChallenge(client, challengeRequest, authToken);
      var expected = SecondDeviceFinalMsg(z: [
        BigInt.parse(
            '3633826251616834446657553661530373736489206587264246793596555854504147120873052400272122845815239659486740186516083053240689380'),
      ]);

      expect(actual, isA<SecondDeviceFinalMsg>());
      expect(actual.z, expected.z);
    });

    test('throws an exception if the http call completes unauthorized', () {
      final client = MockClient();

      ChallengeRequest challengeRequest = ChallengeRequest(
          challenge: BigInt.parse('111222333444555666777888'),
          challengeRandomCoin: BigInt.parse('999999900000008888888001'));
      String authToken = 'wrong token';

      when(client.post(
        Uri.parse('/rest/challenge'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'AuthToken': 'wrong token',
        },
        body: challengeRequest.toJson(),
      )).thenAnswer((_) async => http.Response('Unauthorized', 401));

      expect(createChallenge(client, challengeRequest, authToken),
          throwsException);
    });

    test(
        'throws an exception if the http call completes with an unexpected error',
        () {
      final client = MockClient();

      ChallengeRequest challengeRequest = ChallengeRequest(
          challenge: BigInt.parse('111222333444555666777888'),
          challengeRandomCoin: BigInt.parse('999999900000008888888001'));
      String authToken = 'wrong token';

      when(client.post(
        Uri.parse('/rest/challenge'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'AuthToken': 'wrong token',
        },
        body: challengeRequest.toJson(),
      )).thenAnswer((_) async => http.Response('Not found', 402));

      expect(createChallenge(client, challengeRequest, authToken),
          throwsException);
    });
  });
}
