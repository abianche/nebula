part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final SettingsModel settings;

  const SettingsState(this.settings);

  @override
  List<Object?> get props => [settings];
}
