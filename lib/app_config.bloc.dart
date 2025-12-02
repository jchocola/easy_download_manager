// ignore_for_file: camel_case_types

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:easy_download_manager/data/repository/shared_prefs_impl.dart';
import 'package:easy_download_manager/main.dart';

///
/// EVENT
///
abstract class AppConfigBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppConfigBlocEvent_load extends AppConfigBlocEvent {}

class AppConfigBlocEvent_changeLocale extends AppConfigBlocEvent {
  final String locale;

  AppConfigBlocEvent_changeLocale({required this.locale});

  @override
  List<Object?> get props => [locale];
}

///
/// STATE
///
abstract class AppConfigBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppConfigBloacState_Initial extends AppConfigBlocState {}

class AppConfigBloacState_Loaded extends AppConfigBlocState {
  final String locale;

  AppConfigBloacState_Loaded({this.locale = 'en'});


  

  @override
  List<Object?> get props => [locale];

  AppConfigBloacState_Loaded copyWith({
    String? locale,
  }) {
    return AppConfigBloacState_Loaded(
      locale: locale ?? this.locale,
    );
  }
}

///
/// BLOC
///

class AppConfigBloc extends Bloc<AppConfigBlocEvent, AppConfigBlocState> {
  final SharedPrefsImpl sharedPrefs;

  AppConfigBloc({required this.sharedPrefs})
    : super(AppConfigBloacState_Initial()) {

      ///
      /// load
      ///
    on<AppConfigBlocEvent_load>((event, emit) async {
      final locale = sharedPrefs.getLocale();
      logger.i('AppConfigBloc: load locale: $locale');
      emit(AppConfigBloacState_Loaded(locale: locale));
    });


    ///
    /// change locale
    ///
    on<AppConfigBlocEvent_changeLocale>((event, emit) async {
      await sharedPrefs.setLocale(event.locale);
      logger.i('AppConfigBloc: change locale: ${event.locale}');
      emit(AppConfigBloacState_Loaded(locale: event.locale));
    });

  }
}
