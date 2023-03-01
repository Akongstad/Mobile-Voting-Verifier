import 'dart:ffi';

import 'package:mobile_voting_verifier/models/content.dart';
import 'package:mobile_voting_verifier/models/i_18_n.dart';

abstract class Core3Ballot {
  Core3Ballot();

  Core3Ballot.fromJson();
}

class Core3StandardBallot extends Core3Ballot {
  final bool calculateAvailableVotes;
  final String? colorSchema;
  final Content? contentAbove;
  final Content? contentBelow;
  final String? externalIdentification;
  final String id;
  final List<CandidateList> lists;
  final int? maxListsWithChoices;
  final int maxVotes;
  final int? maxVotesForCandidates;
  final int? maxVotesForLists;
  final int minVotes;
  final int? minVotesForCandidates;
  final int? minVotesForLists;
  final bool prohibitLessVotes;
  final bool prohibitMoreVotes;
  final bool showAbstainOption;
  final bool showInvalidOption;
  final I18n<String> title;
  final type = "STANDARD_BALLOT";

  Core3StandardBallot({
    required this.calculateAvailableVotes,
    this.colorSchema,
    this.contentAbove,
    this.contentBelow,
    this.externalIdentification,
    required this.id,
    required this.lists,
    this.maxListsWithChoices,
    required this.maxVotes,
    this.maxVotesForCandidates,
    this.maxVotesForLists,
    required this.minVotes,
    this.minVotesForCandidates,
    this.minVotesForLists,
    required this.prohibitLessVotes,
    required this.prohibitMoreVotes,
    required this.showAbstainOption,
    required this.showInvalidOption,
    required this.title,
  });

  factory Core3StandardBallot.fromJson(Map<String, dynamic> json) => Core3StandardBallot(
          calculateAvailableVotes: json['calculateAvailableVotes'] as bool,
          colorSchema: json['colorSchema'],
          contentAbove: Text.fromJson(json['contentAbove']["value"]),
          contentBelow: Text.fromJson(json['contentBelow']["value"]),
          externalIdentification: json['externalIdentification'],
          id: json['id'],
          lists: (json['lists'] as List)
              .map((e) => CandidateList.fromJson(e))
              .toList(),
          maxListsWithChoices: (json['maxListsWithChoices'] ?? 1 << 31) as int,
          maxVotes: json['maxVotes'] as int,
          maxVotesForCandidates: (json['maxVotesForCandidates'] ??
              1 << 31) as int,
          maxVotesForLists: (json['maxVotesForLists'] ?? 1 << 31) as int,
          minVotes: (json['minVotes'] as int),
          minVotesForCandidates: (json['minVotesForCandidates'] ?? 0) as int,
          minVotesForLists: (json['minVotesForLists'] ?? 0) as int,
          prohibitLessVotes: json['prohibitLessVotes'] as bool,
          prohibitMoreVotes: json['prohibitMoreVotes'] as bool,
          showAbstainOption: json['showAbstainOption'] as bool,
          showInvalidOption: json['showInvalidOption'] as bool,
          title: I18n.fromJsonString(json['title'])
      );
}

class AutofillConfig {
  final Bool skipVoted;
  final AutofillSpec spec;

  AutofillConfig({
    required this.skipVoted,
    required this.spec,
  });
}

enum AutofillSpec {
  balanced,
  topdown;
}

class CandidateList {
  final AutofillConfig? autofillConfig;
  final List<CandidateSpec> candidates;
  final List<I18n> columnHeaders;
  final DerivedListVotesSpec? derivedListVotes;
  final String? externalIdentification;
  final String id;
  final int maxVotesForList;
  final int maxVotesOnList;
  final int? maxVotesTotal;
  final int minVotesForList;
  final int minVotesOnList;
  final int? minVotesTotal;
  final I18n<String>? title;
  final Bool voteCandidateXorList;

  CandidateList({
    this.autofillConfig,
    required this.candidates,
    required this.columnHeaders,
    this.derivedListVotes,
    this.externalIdentification,
    required this.id,
    required this.maxVotesForList,
    required this.maxVotesOnList,
    this.maxVotesTotal,
    required this.minVotesForList,
    required this.minVotesOnList,
    this.minVotesTotal,
    this.title,
    required this.voteCandidateXorList,
  });

  factory CandidateList.fromJson(Map<String, dynamic> json){
    return throw UnimplementedError();
  }
}

class CandidateSpec {
  final List<Content> columns;
  final String? externalIdentification;
  final String id;
  final int maxVotes;
  final int minVotes;
  final int? writeInSize;

  CandidateSpec({
    required this.columns,
    this.externalIdentification,
    required this.id,
    required this.maxVotes,
    required this.minVotes,
    this.writeInSize,
  });
}

class ColumnProperties {
  final Bool hide;

  ColumnProperties({
    required this.hide,
  });
}

class DerivedListVotesSpec {
  final Variant variant;

  DerivedListVotesSpec({
    required this.variant,
  });
}

enum Variant {
  eachVoteCounts,
  atMostOne;
}
