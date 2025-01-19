import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/drawer.dart';
import 'package:nebula/navigation/bloc/navigation_bloc.dart';
import 'package:nebula/settings/bloc/settings_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(create: (_) => SettingsBloc()),
      ],
      child: MaterialApp(
        title: 'Nebula',
        home: const Navigation(),
      ),
    );
  }
}
