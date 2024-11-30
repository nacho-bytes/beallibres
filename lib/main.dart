import 'package:flutter/material.dart' show BuildContext, MaterialApp, StatelessWidget, Widget, WidgetsFlutterBinding, runApp;
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'firebase_options.dart' show DefaultFirebaseOptions;
import 'package:flutter_gen/gen_l10n/app_localizations.dart' show AppLocalizations;

import 'router/router.dart' show router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      onGenerateTitle: (final BuildContext context) => AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
