import 'package:equatable/equatable.dart';

enum AppTheme { light, dark, system }

class SettingsModel extends Equatable {
  final AppTheme appTheme;
  final bool enableBetaFeatures;

  const SettingsModel({
    required this.appTheme,
    required this.enableBetaFeatures,
  });

  factory SettingsModel.initialSettings() {
    return const SettingsModel(
      appTheme: AppTheme.light,
      enableBetaFeatures: false,
    );
  }

  @override
  List<Object?> get props => [appTheme, enableBetaFeatures];

  SettingsModel copyWith({
    AppTheme? appTheme,
    bool? enableBetaFeatures,
  }) {
    return SettingsModel(
      appTheme: appTheme ?? this.appTheme,
      enableBetaFeatures: enableBetaFeatures ?? this.enableBetaFeatures,
    );
  }
}

SettingsModel getInitialSettings() {
  return const SettingsModel(
    appTheme: AppTheme.system,
    enableBetaFeatures: false,
  );
}
