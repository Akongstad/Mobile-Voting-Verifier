import 'package:mobile_voting_verifier/models/content.dart';
import 'package:mobile_voting_verifier/models/i_18_n.dart';

sealed

class Core3Ballot {

  Core3Ballot();

  factory Core3Ballot.fromJson(Map<String, dynamic> json) =>
    switch(json["type"]) {
      "STANDARD_BALLOT" => Core3StandardBallot.fromJson(json)
    };

  // Overridable getters, such that fields can be accessed polymorphically
  bool get calculateAvailableVotes => throw ArgumentError("The supertype Core3Ballot is not supposed to be instantiated");
  String? get colorSchema => throw ArgumentError("The supertype Core3Ballot is not supposed to be instantiated");
  Content? get contentAbove => throw ArgumentError("The supertype Core3Ballot is not supposed to be instantiated");
  Content? get contentBelow => throw ArgumentError("The supertype Core3Ballot is not supposed to be instantiated");
  String? get externalIdentification => throw ArgumentError("The supertype Core3Ballot is not supposed to be instantiated");
  String get id => throw ArgumentError("The supertype Core3Ballot is not supposed to be instantiated");
  List<CandidateList> get lists => throw ArgumentError("The supertype Core3Ballot is not supposed to be instantiated");
  int? get maxListsWithChoices => throw ArgumentError("The supertype Core3Ballot is not supposed to be instantiated");
  int get maxVotes => throw ArgumentError("The supertype Core3Ballot is not supposed to be instantiated");
  int? get maxVotesForCandidates => throw ArgumentError("The supertype Core3Ballot is not supposed to be instantiated");
  int? get maxVotesForLists => throw ArgumentError("The supertype Core3Ballot is not supposed to be instantiated");
  int get minVotes => throw ArgumentError("The supertype Core3Ballot is not supposed to be instantiated");
  int? get minVotesForCandidates => throw ArgumentError("The supertype Core3Ballot is not supposed to be instantiated");
  int? get minVotesForLists => throw ArgumentError();
  bool get prohibitLessVotes => throw ArgumentError();
  bool get prohibitMoreVotes => throw ArgumentError();
  bool get showAbstainOption => throw ArgumentError();
  bool get showInvalidOption => throw ArgumentError();
  I18n<String> get title =>throw ArgumentError();
}

class Core3StandardBallot extends Core3Ballot {
  @override
  final bool calculateAvailableVotes;
  @override
  final String? colorSchema;
  @override
  final Content? contentAbove;
  @override
  final Content? contentBelow;
  @override
  final String? externalIdentification;
  @override
  final String id;
  @override
  final List<CandidateList> lists;
  @override
  final int? maxListsWithChoices;
  @override
  final int maxVotes;
  @override
  final int? maxVotesForCandidates;
  @override
  final int? maxVotesForLists;
  @override
  final int minVotes;
  @override
  final int? minVotesForCandidates;
  @override
  final int? minVotesForLists;
  @override
  final bool prohibitLessVotes;
  @override
  final bool prohibitMoreVotes;
  @override
  final bool showAbstainOption;
  @override
  final bool showInvalidOption;
  @override
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

  factory Core3StandardBallot.fromJson(Map<String, dynamic> json) =>
      Core3StandardBallot(
          calculateAvailableVotes: json['calculateAvailableVotes'] as bool,
          colorSchema: json['colorSchema'],
          contentAbove: json['contentAbove'] !=null ? Content.fromJson(json['contentAbove']) : null,
          contentBelow: json['contentBelow'] != null ? Content.fromJson(json['contentBelow']): null,
          externalIdentification: json['externalIdentification'],
          id: json['id'],
          lists: (json['lists'] as List)
              .map((e) => CandidateList.fromJson(e))
              .toList(),
          maxListsWithChoices: (json['maxListsWithChoices'] ?? 1 << 31) as int,
          maxVotes: json['maxVotes'] as int,
          maxVotesForCandidates:
          (json['maxVotesForCandidates'] ?? 1 << 31) as int,
          maxVotesForLists: (json['maxVotesForLists'] ?? 1 << 31) as int,
          minVotes: (json['minVotes'] as int),
          minVotesForCandidates: (json['minVotesForCandidates'] ?? 0) as int,
          minVotesForLists: (json['minVotesForLists'] ?? 0) as int,
          prohibitLessVotes: json['prohibitLessVotes'] as bool,
          prohibitMoreVotes: json['prohibitMoreVotes'] as bool,
          showAbstainOption: json['showAbstainOption'] as bool,
          showInvalidOption: json['showInvalidOption'] as bool,
          title: I18n.fromJsonString(json['title']));
}

class AutofillConfig {
  final bool skipVoted;
  final AutofillSpec spec;

  AutofillConfig({
    required this.skipVoted,
    required this.spec,
  });

  AutofillConfig.fromJson(Map<String, dynamic> json)
      : skipVoted = json['skipVoted'] as bool,
        spec = AutofillSpec.fromJson(json['spec']);
}

enum AutofillSpec {
  BALANCED,
  TOPDOWN;

  static AutofillSpec fromJson(String json) => values.byName(json);
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
  final bool voteCandidateXorList;
  final bool countCandidateVotesAsListVotes;

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
    required this.countCandidateVotesAsListVotes
  });

  factory CandidateList.fromJson(Map<String, dynamic> json) {
    return CandidateList(
        autofillConfig: json["autofillConfig"] != null ? AutofillConfig.fromJson(json["autofillConfig"]): null,
        candidates: (json["candidates"] as List).map((e) => CandidateSpec.fromJson(e)).toList(),
        columnHeaders: (json["columnHeaders"] as List).map((e) => I18n.fromJsonString(e)).toList(),
        id: json["id"],
        derivedListVotes: json["derivedListVotes"] != null ? DerivedListVotesSpec.fromJson(json["derivedListVotes"]) : null,
        externalIdentification: json["derivedListVotes"],
        maxVotesForList: json["maxVotesForList"] as int,
        maxVotesOnList: json["maxVotesOnList"] as int,
        maxVotesTotal: json["maxVotesTotal"] != null ? json["maxVotesTotal"] as int : null,
        minVotesForList: json["minVotesForList"] as int,
        minVotesOnList: json["minVotesOnList"] as int,
        minVotesTotal: json["minVotesTotal"] != null ? json["minVotesTotal"] as int : null,
        title: json["title"] != null ? I18n.fromJsonString(json["title"]): null,
        voteCandidateXorList: json["voteCandidateXorList"] as bool,
        countCandidateVotesAsListVotes: json["countCandidateVotesAsListVotes"] as bool
    );
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
  factory CandidateSpec.fromJson(Map<String, dynamic> json)
  => CandidateSpec(
      columns: (json["columns"] as List).map((e) => Content.fromJson(e)).toList(),
      externalIdentification: json["externalIdentification"] ,
      id: json["id"],
      maxVotes: json["maxVotes"] as int,
      minVotes: json["minVotes"] as int,
      writeInSize: json["writeInSize"] != null ? json["writeInSize"] as int : null
  );
}

class ColumnProperties {
  final bool hide;

  ColumnProperties({
    required this.hide,
  });
}

class DerivedListVotesSpec {
  final Variant variant;

  DerivedListVotesSpec({
    required this.variant,
  });
  DerivedListVotesSpec.fromJson(Map<String, dynamic> json) :
      variant = Variant.fromJson(json["variant"]);
}

enum Variant {
  EACH_VOTE_COUNTS,
  AT_MOST_ONE;
  static Variant fromJson(String json) => values.byName(json);
}
