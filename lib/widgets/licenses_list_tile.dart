import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LicensesListTile extends StatelessWidget {
  const LicensesListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return AboutListTile(
            applicationLegalese: '© ${DateTime.now().year} Alessio Bianchetti\nApache-2.0 license',
          );
        }

        return AboutListTile(
          applicationIcon: const FlutterLogo(),
          applicationName: snapshot.data?.appName,
          applicationVersion: snapshot.data?.version,
          applicationLegalese: '© ${DateTime.now().year} Alessio Bianchetti\nApache-2.0 license',
        );
      },
    );
  }
}
