import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mobile_voting_verifier/models/election_data.dart';
import 'package:mobile_voting_verifier/models/enums/language.dart';
import 'package:mobile_voting_verifier/models/i_18_n.dart';
import 'package:test/test.dart';

void main() {
  var client = MockClient((request) async {
    if (request.url.path != "/rest/electionData") {
      return Response("", 404);
    }
    return Response(
        json.encode({
          'title': {'default': 'My Election Title', 'value': {}},
          'languages': ['EN', 'DE']
        }),
        200,
        headers: {'content-type': 'application/json'});
  });

  test('Election data should be fetched from vote server API', () async {
    var response = await client.get(Uri.https('', '/rest/electionData'));

    var matcher = electionDataFromJson(jsonDecode(response.body));

    ElectionData expected = ElectionData(
        languages: [Language.en, Language.de],
        title: I18n(default_: "My Election Title", value: {}));

    expect(expected.languages, matcher.languages);
    expect(expected.title.default_, matcher.title.default_);
    expect(expected.title.value, matcher.title.value);
  });
}
