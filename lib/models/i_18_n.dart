import 'package:mobile_voting_verifier/models/enums/language.dart';

class I18n<T> {
  final T default_;
  final Map<Language, T> value;


  I18n({
    required this.default_,
    required this.value,
  });

  factory I18n.fromJsonString(Map<String, dynamic> jsonData){
    return I18n(
      default_: jsonData['default'],
      value: (jsonData['value'] as Map).map((key, value) => MapEntry(Language.fromJson(key), value))
    );
  }
  factory I18n.fromJsonMap(Map<String, dynamic> jsonData,
      T Function(Map<String, dynamic>) valueFromJsonFunction ){
    return I18n(
        default_: valueFromJsonFunction(jsonData['default']),
        value: (jsonData['value'] as Map).map((key, value) =>
            MapEntry(Language.fromJson(key), valueFromJsonFunction(value)))
    );
  }
}
