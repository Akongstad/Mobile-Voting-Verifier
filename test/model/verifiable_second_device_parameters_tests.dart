import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_voting_verifier/models/core_3_ballot.dart';
import 'package:mobile_voting_verifier/models/i_18_n.dart';
import 'package:mobile_voting_verifier/models/verifiable_second_device_parameters.dart';

void main() {
  final verifiableSecondDeviceParameters = VerifiableSecondDeviceParameters(
      ballots: [Core3StandardBallot(
          id: "0",
          title: I18n(default_: "ballot 0", value: {}),
          lists: [CandidateList(
              candidates: [CandidateSpec(columns: [], id: "0-0-0", maxVotes: 1, minVotes: 0), CandidateSpec(columns: [], id: "0-0-1", maxVotes: 1, minVotes: 0),],
              columnHeaders: [I18n(default_: "ballot 0", value: {})],
              id: "0-0",
              maxVotesForList: 999,
              maxVotesOnList: 999,
              minVotesForList: 0,
              minVotesOnList: 0,
              voteCandidateXorList: false,
              countCandidateVotesAsListVotes: false,
              title: I18n(default_: "List 0", value: {}))],
          maxVotes: 999,
          minVotes: 0,
          prohibitLessVotes: true,
          prohibitMoreVotes: true,
          showAbstainOption: false,
          showInvalidOption: true,
          calculateAvailableVotes: false,
          minVotesForLists: 0,
          minVotesForCandidates: 0,
          maxVotesForLists: 1 << 31,
          maxVotesForCandidates: 1 << 31,
          maxListsWithChoices: 1 << 31,

      )],
      publicKey: "0279c6148c38b2ed3d52dcc3f21c30b4923ed764a94e39d6bf62030e7e66e5d6a1",
      verificationKey: "30820122300d06092a864886f70d01010105000382010f003082010a0282010100883474dfb66b3b466636932bdd9c4edbd5052860009e87e552bbbe2c6602fdc009fa444eebe3249a9ca63de9891707025a3dfba4b825dc481c9f28c7d70aa0b63f77fe5a970f557892826162c5bbe683db5a01d508b5885d9a0e1a36ac73D");

  final Map<String, dynamic> verifiableSecondDeviceParametersJson = {
    "publicKey":
        "0279c6148c38b2ed3d52dcc3f21c30b4923ed764a94e39d6bf62030e7e66e5d6a1",
    "verificationKey":
        "30820122300d06092a864886f70d01010105000382010f003082010a0282010100883474dfb66b3b466636932bdd9c4edbd5052860009e87e552bbbe2c6602fdc009fa444eebe3249a9ca63de9891707025a3dfba4b825dc481c9f28c7d70aa0b63f77fe5a970f557892826162c5bbe683db5a01d508b5885d9a0e1a36ac73D",
    "ballots": [
      {
        "type": "STANDARD_BALLOT",
        "id": "0",
        "title": {"default": "ballot 0", "value": {}},
        "lists": [
          {
            "id": "0-0",
            "title": {"default": "List 0", "value": {}},
            "columnHeaders": [
              {"default": "List 0", "value": {}}
            ],
            "candidates": [
              {"id": "0-0-0", "columns": [], "maxVotes": 1, "minVotes": 0},
              {"id": "0-0-1", "columns": [], "maxVotes": 1, "minVotes": 0}
            ],
            "maxVotesOnList": 999,
            "minVotesOnList": 0,
            "maxVotesForList": 999,
            "minVotesForList": 0,
            "voteCandidateXorList": false,
            "countCandidateVotesAsListVotes": false
          }
        ],
        "showInvalidOption": true,
        "showAbstainOption": false,
        "maxVotes": 999,
        "minVotes": 0,
        "prohibitMoreVotes": true,
        "prohibitLessVotes": true,
        "calculateAvailableVotes": false
      }
    ]
  };

  group(' VerifiableSecondDeviceParameters.fromJson returns valid VerifiableSecondDeviceParameters object', () {
    test('VerifiableSecondDeviceParameters.fromJson returns valid VerifiableSecondDeviceParameters object given valid json', () {
      final actual = VerifiableSecondDeviceParameters.fromJson(verifiableSecondDeviceParametersJson);
      expect(actual.verificationKey, verifiableSecondDeviceParameters.verificationKey);
      expect(actual.publicKey, verifiableSecondDeviceParameters.publicKey);
      expect(actual.ballots.length, verifiableSecondDeviceParameters.ballots.length);

      expect(actual.ballots.first.showAbstainOption, verifiableSecondDeviceParameters.ballots.first.showAbstainOption);
      expect(actual.ballots.first.title.default_, verifiableSecondDeviceParameters.ballots.first.title.default_);
      expect(actual.ballots.first.showInvalidOption, verifiableSecondDeviceParameters.ballots.first.showInvalidOption);
      expect(actual.ballots.first.prohibitMoreVotes, verifiableSecondDeviceParameters.ballots.first.prohibitMoreVotes);
      expect(actual.ballots.first.prohibitLessVotes, verifiableSecondDeviceParameters.ballots.first.prohibitLessVotes);
      expect(actual.ballots.first.minVotesForLists, verifiableSecondDeviceParameters.ballots.first.minVotesForLists);
      expect(actual.ballots.first.minVotesForCandidates, verifiableSecondDeviceParameters.ballots.first.minVotesForCandidates);
      expect(actual.ballots.first.maxVotesForLists, verifiableSecondDeviceParameters.ballots.first.maxVotesForLists);

      expect(actual.ballots.first.maxVotesForCandidates, verifiableSecondDeviceParameters.ballots.first.maxVotesForCandidates);

      expect(actual.ballots.first.maxListsWithChoices, verifiableSecondDeviceParameters.ballots.first.maxListsWithChoices);
      expect(actual.ballots.first.externalIdentification, verifiableSecondDeviceParameters.ballots.first.externalIdentification);
      expect(actual.ballots.first.contentBelow, verifiableSecondDeviceParameters.ballots.first.contentBelow);
      expect(actual.ballots.first.contentAbove, verifiableSecondDeviceParameters.ballots.first.contentAbove);
      expect(actual.ballots.first.colorSchema, verifiableSecondDeviceParameters.ballots.first.colorSchema);
      expect(actual.ballots.first.calculateAvailableVotes, verifiableSecondDeviceParameters.ballots.first.calculateAvailableVotes);
      expect(actual.ballots.first.id, verifiableSecondDeviceParameters.ballots.first.id);
    });
    test('fromJson returns valid VerifiableSecondDeviceParameters.ballots.lists object given valid json', () {
      final actual = VerifiableSecondDeviceParameters.fromJson(verifiableSecondDeviceParametersJson).ballots.first.lists;
      final expected = verifiableSecondDeviceParameters.ballots.first.lists;
      expect(actual.length, expected.length);
      expect(actual.first.id, expected.first.id);
      expect(actual.first.externalIdentification, expected.first.externalIdentification);
      expect(actual.first.title?.value, expected.first.title?.value);
      expect(actual.first.countCandidateVotesAsListVotes, expected.first.countCandidateVotesAsListVotes);
      expect(actual.first.columnHeaders.first.value, expected.first.columnHeaders.first.value);

      expect(actual.first.autofillConfig?.skipVoted, expected.first.autofillConfig?.skipVoted);
      expect(actual.first.autofillConfig?.spec.name, expected.first.autofillConfig?.spec.name);

      expect(actual.first.maxVotesForList, expected.first.maxVotesForList);
      expect(actual.first.maxVotesOnList, expected.first.maxVotesOnList);
      expect(actual.first.maxVotesTotal, expected.first.maxVotesTotal);

      expect(actual.first.minVotesForList, expected.first.minVotesForList);
      expect(actual.first.minVotesOnList, expected.first.minVotesOnList);
      expect(actual.first.minVotesTotal, expected.first.minVotesTotal);

      expect(actual.first.voteCandidateXorList, expected.first.voteCandidateXorList);
      expect(actual.first.derivedListVotes, expected.first.derivedListVotes);

      expect(actual.first.candidates.first.externalIdentification, expected.first.externalIdentification);
      expect(actual.first.candidates.first.id, expected.first.candidates.first.id);
      expect(actual.first.candidates.first.minVotes, expected.first.candidates.first.minVotes);
      expect(actual.first.candidates.first.maxVotes, expected.first.candidates.first.maxVotes);
      expect(actual.first.candidates.first.writeInSize, expected.first.candidates.first.writeInSize);
      expect(actual.first.candidates.first.columns, expected.first.candidates.first.columns);
    });
  });
}
