import 'package:flutter/material.dart' show ElevatedButton;
import 'package:flutter/widgets.dart' show BuildContext, EdgeInsets, Padding, StatelessWidget, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:go_router/go_router.dart' show GoRouterHelper;

import '../../../app/app.dart' show $HomeRouteExtension, AuthenticationBloc, AuthenticationLogoutPressed, HomeRoute;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () {
          context.read<AuthenticationBloc>().add(const AuthenticationLogoutPressed());
          context.go(const HomeRoute().location);
        },
        child: Text(AppLocalizations.of(context)!.logout),
      ),
    );
}
