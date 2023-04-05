import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:local_cryptography/local_cryptography.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_election_data_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchElectionData', () {
    final client = MockClient();

    test('returns ElectionData if the http call completes successfully',
        () async {
      when(client.get(Uri.parse('/rest/electionData'))).thenAnswer((_) async =>
          http.Response('{"title": {"default": "My Election Title"}}', 200));

      var actual = await fetchElectionData(client);
      var expected = ElectionData(title: 'My Election Title');

      expect(actual, isA<ElectionData>());
      expect(actual.title, expected.title);
    });

    test(
        'throws an exception if the http call completes with an unexpected error',
        () {
      when(client.get(Uri.parse('/rest/electionData')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchElectionData(client), throwsException);
    });
  });
}
