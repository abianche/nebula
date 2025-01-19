import 'package:equatable/equatable.dart';
import 'package:nebula/models/settings_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(
          SettingsState(
            SettingsModel.initialSettings(),
          ),
        ) {
    on<UpdateSettings>((event, emit) {
      emit(
        SettingsState(
          state.settings.copyWith(
            appTheme: event.appTheme,
            enableBetaFeatures: event.enableBetaFeatures,
          ),
        ),
      );
    });
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    try {
      return SettingsState(
        SettingsModel(
          appTheme: AppTheme.values[json['appTheme'] as int],
          enableBetaFeatures: json['enableBetaFeatures'] as bool,
        ),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return {
      'appTheme': state.settings.appTheme.index,
      'enableBetaFeatures': state.settings.enableBetaFeatures,
    };
  }
}
