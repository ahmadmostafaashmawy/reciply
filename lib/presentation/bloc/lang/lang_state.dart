import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List get props => [];
}

class LanguageInitial extends LanguageState {
  @override
  String toString() => 'LanguageInitial';
}

class LanguageLoading extends LanguageState {}

class LanguageChanged extends LanguageState {
  final String language;

  LanguageChanged({required this.language});

  List get props => [language];
}
