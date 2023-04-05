import 'package:flutter_test/flutter_test.dart';
import 'package:local_cryptography/local_cryptography.dart';

void assertSecondDeviceLoginResponse(SecondDeviceLoginResponse actual, SecondDeviceLoginResponse secondDeviceLoginResponse){
  //Actual, expected
  expect(actual.initialMessageJSON,
      secondDeviceLoginResponse.initialMessageJSON);
  expect(actual.messages, secondDeviceLoginResponse.messages);
  expect(actual.electionId, secondDeviceLoginResponse.electionId);

  expect(actual.title.default_, secondDeviceLoginResponse.title.default_);
  expect(actual.title.value, secondDeviceLoginResponse.title.value);

  expect((actual.contentAbove as ContentText).contentType,
      (secondDeviceLoginResponse.contentAbove as ContentText).contentType);
  expect((actual.contentAbove as ContentText).value.default_,
      (secondDeviceLoginResponse.contentAbove as ContentText).value.default_);
  expect((actual.contentAbove as ContentText).value.value,
      (secondDeviceLoginResponse.contentAbove as ContentText).value.value);

  expect(actual.allowInvalid, secondDeviceLoginResponse.allowInvalid);
  expect(actual.ballotVoterId, secondDeviceLoginResponse.ballotVoterId);
  expect(actual.languages, secondDeviceLoginResponse.languages);
  expect(actual.logo, secondDeviceLoginResponse.logo);
  expect(actual.publicLabel, secondDeviceLoginResponse.publicLabel);
  expect(actual.token, secondDeviceLoginResponse.token);
}

main() {

  //Arrange SecondDeviceLoginResponse
  final secondDeviceLoginResponse = SecondDeviceLoginResponse(
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
          "initialMessage",
    },
    "status": "OK"
  };

  //Test Cases
  group("fromJson tests", () {
    test("fromJson returns SecondDeviceLoginResponse given json object", () {
      final actual =
          SecondDeviceLoginResponse.fromJson(jsonSecondDeviceLoginResponse);

      //Actual, expected
      assertSecondDeviceLoginResponse(actual, secondDeviceLoginResponse);
    });
  });
}
