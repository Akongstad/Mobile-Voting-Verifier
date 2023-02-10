import 'package:mobile_voting_verifier/models/enums/language.dart';

class I18n<T> {
  final T default_;
  final Map<Language, T> value;

  I18n({
    required this.default_,
    required this.value,
  });
}
