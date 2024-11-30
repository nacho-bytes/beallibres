import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart' show BuildContext, MaterialApp, StatelessWidget, Widget, WidgetsFlutterBinding, runApp;
import 'package:flutter_gen/gen_l10n/app_localizations.dart' show AppLocalizations;

import 'firebase_options.dart' show DefaultFirebaseOptions;
import 'router/router.dart' show router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

/// The main application widget.
/// 
/// This widget is the root of the application.
class MyApp extends StatelessWidget {
  /// Creates the main application widget.
  /// 
  /// The [key] is optional and defaults to `null`.
  const MyApp({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => MaterialApp.router(
      routerConfig: router,
      onGenerateTitle: (final BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
}
