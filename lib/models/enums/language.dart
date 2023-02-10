enum Language {
  de,
  en,
  fr,
  fi,
  it,
  pl,
  nl,
  cz,
  es,
  no,
  dk,
  rou,
  svk,
  se,
  ru,
  hu,
  ar;

  static Language fromString(String str) => values.byName(str);
}
