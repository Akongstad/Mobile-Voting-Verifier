import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_voting_verifier/models/content.dart';
import 'package:mobile_voting_verifier/models/enums/language.dart';
import 'package:mobile_voting_verifier/models/i_18_n.dart';
import 'package:mobile_voting_verifier/models/second_device_login_response.dart';

main() {
  //Arrange SecondDeviceLoginResponse
  final secondDeviceLoginResponse = SecondDeviceLoginResponse(
      allowInvalid: true,
      ballotVoterId:
          "0205bf2e14496f68c0f86f6b313f210a9393edb083821dcc4f9914cab9c51c9f2e",
      electionId: "bfced618-34aa-4b78-ba5b-d21dc04a1a7e",
      initialMessage:
          "{\"secondDeviceParametersJson\":\"{\\\"publicKey\\\":\\\"030588c6c80497da9e50bf56a4853c9fd3dd945a5e2ed741ccf783c5538611da26\",\"",
      languages: [Language.EN, Language.DE],
      messages: {},
      publicLabel: "A",
      title: I18n(default_: "My Election Title", value: {}),
      contentAbove: Text(value: I18n(default_: "This is content above", value: {})),
      token:
          "MDIwNWJmMmUxNDQ5NmY2OGMwZjg2ZjZiMzEzZjIxMGE5MzkzZWRiMDgzODIxZGNjNGY5OTE0Y2FiOWM1MWM5ZjJl");

  //Arrange JSON object
  final Map<String, dynamic> jsonSecondDeviceLoginResponse = {
    "value": {
      "token":
          "MDIwNWJmMmUxNDQ5NmY2OGMwZjg2ZjZiMzEzZjIxMGE5MzkzZWRiMDgzODIxZGNjNGY5OTE0Y2FiOWM1MWM5ZjJl",
      "ballotVoterId":
          "0205bf2e14496f68c0f86f6b313f210a9393edb083821dcc4f9914cab9c51c9f2e",
      "electionId": "bfced618-34aa-4b78-ba5b-d21dc04a1a7e",
      "languages": ["EN", "DE"],
      "title": {"default": "My Election Title", "value": {}},
      "contentAbove": {
        "value": {"default": "This is content above", "value": {}},
        "contentType": "TEXT"
      },
      "publicLabel": "A",
      "messages": {},
      "allowInvalid": true,
      "initialMessage":
          "{\"secondDeviceParametersJson\":\"{\\\"publicKey\\\":\\\"030588c6c80497da9e50bf56a4853c9fd3dd945a5e2ed741ccf783c5538611da26\",\"",
    },
    "status": "OK"
  };

  //Test Cases
  group("fromJson tests", () {
    test("fromJson returns SecondDeviceLoginResponse given json object", () {
      final actual = SecondDeviceLoginResponse.fromJson(
          jsonSecondDeviceLoginResponse);

      //Actual, expected
      expect(actual.initialMessage, secondDeviceLoginResponse.initialMessage);
      expect(actual.messages, secondDeviceLoginResponse.messages);
      expect(actual.electionId, secondDeviceLoginResponse.electionId);

      expect(actual.title.default_, secondDeviceLoginResponse.title.default_);
      expect(actual.title.value, secondDeviceLoginResponse.title.value);

      expect((actual.contentAbove as Text).contentType, (secondDeviceLoginResponse.contentAbove as Text).contentType);
      expect((actual.contentAbove as Text).value.default_, (secondDeviceLoginResponse.contentAbove as Text).value.default_);
      expect((actual.contentAbove as Text).value.value, (secondDeviceLoginResponse.contentAbove as Text).value.value);

      expect(actual.allowInvalid, secondDeviceLoginResponse.allowInvalid);
      expect(actual.ballotVoterId, secondDeviceLoginResponse.ballotVoterId);
      expect(actual.languages, secondDeviceLoginResponse.languages);
      expect(actual.logo, secondDeviceLoginResponse.logo);
      expect(actual.publicLabel, secondDeviceLoginResponse.publicLabel);
      expect(actual.token, secondDeviceLoginResponse.token);

    });
  });
}
