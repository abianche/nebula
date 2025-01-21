import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/drawer.dart';
import 'package:nebula/models/settings_model.dart';
import 'package:nebula/navigation/bloc/navigation_bloc.dart';
import 'package:nebula/note/bloc/note_bloc.dart';
import 'package:nebula/settings/bloc/settings_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(create: (_) => SettingsBloc()),
        BlocProvider(create: (_) => NoteBloc()),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          getThemeMode() {
            switch (state.settings.appTheme) {
              case AppTheme.light:
                return ThemeMode.light;
              case AppTheme.dark:
                return ThemeMode.dark;
              default:
                return ThemeMode.system;
            }
          }

          return MaterialApp(
            title: 'Nebula',
            home: const Navigation(),
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: getThemeMode(),
          );
        },
      ),
    );
  }
}
