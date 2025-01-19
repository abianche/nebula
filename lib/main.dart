import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nebula/app.dart';
import 'package:nebula/logger.dart';
import 'package:path_provider/path_provider.dart';

final logger = getLogger('main');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureLogger();

  logger.i('App started');

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb ? HydratedStorageDirectory.web : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  runApp(const App());
}
