enum Language {
  DE,
  EN,
  FR,
  FI,
  IT,
  PL,
  NL,
  CZ,
  ES,
  NO,
  DK,
  ROU,
  SVK,
  SE,
  RU,
  HU,
  AR;
  String toJson() => name;
  static Language fromJson(String json) => values.byName(json);
}

