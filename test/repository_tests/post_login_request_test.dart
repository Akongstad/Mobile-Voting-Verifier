import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:local_cryptography/local_cryptography.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_login_request_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('postLoginRequest', () {
    final client = MockClient();
    test(
        'postLoginRequest returns SecondDeviceLoginResponse when code 200 and status OK',
        () async {
      SecondDeviceLogin loginRequest = SecondDeviceLogin(
          challengeCommitment: 'challenge-commitment',
          nonce:
              '93af68ebc62f281518067b28edcdcb59b05397d8b95be4b01327fbc41ab025a5',
          password: '530728',
          voterId: 'voterA');

      when(client.post(
        Uri.parse('/rest/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: loginRequest.toJson(),
      )).thenAnswer((_) async => http.Response(
          '{"value": {"token" : "MDIwNWJmMmUxNDQ5NmY2OGMwZjg2ZjZiMzEzZjIxMGE5MzkzZWRiMDgzODIxZGNjNGY5OTE0Y2FiOWM1MWM5ZjJl", "ballotVoterId" : "0205bf2e14496f68c0f86f6b313f210a9393edb083821dcc4f9914cab9c51c9f2e", "electionId" : "bfced618-34aa-4b78-ba5b-d21dc04a1a7e", "languages" : ["EN", "DE"], "title" : {"default": "My Election Title", "value" : {}}, "contentAbove": {"value" : {"default": "This is content above", "value": {}}, "contentType": "TEXT"}, "publicLabel" : "A", "messages" : {}, "allowInvalid" : true, "initialMessage": "initialMessage"}, "status": "OK" }',
          200));

      var actual = await login(client, loginRequest);

      final expected = SecondDeviceLoginResponse(
          allowInvalid: true,
          ballotVoterId:
              "0205bf2e14496f68c0f86f6b313f210a9393edb083821dcc4f9914cab9c51c9f2e",
          electionId: "bfced618-34aa-4b78-ba5b-d21dc04a1a7e",
          initialMessageJSON: "initialMessage",
          languages: [Language.EN, Language.DE],
          messages: {},
          publicLabel: "A",
          title: I18n(default_: "My Election Title", value: {}),
          contentAbove:
          ContentText(value: I18n(default_: "This is content above", value: {})),
          token:
              "MDIwNWJmMmUxNDQ5NmY2OGMwZjg2ZjZiMzEzZjIxMGE5MzkzZWRiMDgzODIxZGNjNGY5OTE0Y2FiOWM1MWM5ZjJl");

      expect(actual, isA<SecondDeviceLoginResponse>());

      expect(actual.initialMessageJSON, expected.initialMessageJSON);
      expect(actual.messages, expected.messages);
      expect(actual.electionId, expected.electionId);

      expect(actual.title.default_, expected.title.default_);
      expect(actual.title.value, expected.title.value);

      expect(
          actual.contentAbove?.contentType, expected.contentAbove?.contentType);
      expect((actual.contentAbove as ContentText).value.default_,
          (expected.contentAbove as ContentText).value.default_);
      expect((actual.contentAbove as ContentText).value.value,
          (expected.contentAbove as ContentText).value.value);

      expect(actual.allowInvalid, expected.allowInvalid);
      expect(actual.ballotVoterId, expected.ballotVoterId);
      expect(actual.languages, expected.languages);
      expect(actual.logo, expected.logo);
      expect(actual.publicLabel, expected.publicLabel);
      expect(actual.token, expected.token);
    });

    test(
        'postLoginRequest returns ArgumentError(FailedLoginEvent) when code 200 and status Error',
        () {
      SecondDeviceLogin loginRequest = SecondDeviceLogin(
          challengeCommitment: 'challenge',
          nonce: 'nonce',
          password: 'invalid-password',
          voterId: 'voterId');

      when(client.post(
        Uri.parse('/rest/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: loginRequest.toJson(),
      )).thenAnswer((_) async =>
          http.Response('{"error": "INVALID_LOGIN", "status" : "ERROR"}', 200));

      expect(login(client, loginRequest), throwsArgumentError);
    });
  });
}
