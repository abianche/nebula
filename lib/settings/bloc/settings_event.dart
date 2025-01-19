part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class UpdateSettings extends SettingsEvent {
  final AppTheme? appTheme;
  final bool? enableBetaFeatures;

  const UpdateSettings({this.appTheme, this.enableBetaFeatures});

  @override
  List<Object?> get props => [appTheme, enableBetaFeatures];
}
