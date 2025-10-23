part of 'localization_cubit.dart';

class LocalizationState extends Equatable {
  const LocalizationState({required this.locale});
  final Locale locale;

  LocalizationState copyWith({Locale? locale}) {
    return LocalizationState(locale: locale ?? this.locale);
  }

  @override
  List<Object> get props => [locale];
}
