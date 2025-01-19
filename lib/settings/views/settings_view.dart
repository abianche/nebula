import 'package:nebula/models/settings_model.dart';
import 'package:nebula/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final settings = state.settings;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'App Theme',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ListTile(
                title: const Text('Light'),
                leading: Radio<AppTheme>(
                  value: AppTheme.light,
                  groupValue: settings.appTheme,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<SettingsBloc>().add(
                            UpdateSettings(appTheme: value),
                          );
                    }
                  },
                ),
              ),
              ListTile(
                title: const Text('Dark'),
                leading: Radio<AppTheme>(
                  value: AppTheme.dark,
                  groupValue: settings.appTheme,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<SettingsBloc>().add(
                            UpdateSettings(appTheme: value),
                          );
                    }
                  },
                ),
              ),
              ListTile(
                title: const Text('System'),
                leading: Radio<AppTheme>(
                  value: AppTheme.system,
                  groupValue: settings.appTheme,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<SettingsBloc>().add(
                            UpdateSettings(appTheme: value),
                          );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Beta Features',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SwitchListTile(
                title: const Text('Enable Beta Features'),
                value: settings.enableBetaFeatures,
                onChanged: (value) {
                  context.read<SettingsBloc>().add(
                        UpdateSettings(enableBetaFeatures: value),
                      );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
