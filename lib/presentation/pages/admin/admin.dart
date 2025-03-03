import 'package:flutter/material.dart'
    show BuildContext, Column, EdgeInsets, FilledButton, Padding, StatelessWidget, Text, Theme, Widget, Wrap;
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart' show AppLocalizations;
import 'package:go_router/go_router.dart' show GoRouterHelper;

import '../../../app/app.dart' show $AddUserRouteExtension, AddUserRoute, AuthenticationBloc;
import '../../presentation.dart' show SpacingThemeExtension;

class AdminPage extends StatelessWidget {
  const AdminPage({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal:
          Theme.of(context).extension<SpacingThemeExtension>()!.large,
      vertical:
          Theme.of(context).extension<SpacingThemeExtension>()!.medium,
    ),
    child: Column(
      spacing:
          Theme.of(context).extension<SpacingThemeExtension>()!.large,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.helloUser(
            context.read<AuthenticationBloc>().state.user.data.name.isEmpty
              ? AppLocalizations.of(context)!.user
              : context.read<AuthenticationBloc>().state.user.data.name,
          ),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Wrap(
          spacing:
              Theme.of(context).extension<SpacingThemeExtension>()!.small,
          runSpacing: Theme.of(context)
              .extension<SpacingThemeExtension>()!
              .medium,
          children: <Widget>[
            FilledButton(
              onPressed: () => context.go(const AddUserRoute().location),
              child: Text(
                AppLocalizations.of(context)!.addUser,
              ),
            ),
            FilledButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.removeUser,
              ),
            ),
            FilledButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.addBook,
              ),
            ),
            FilledButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.removeBook,
              ),
            ),
            FilledButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.addLending,
              ),
            ),
            FilledButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.endLending,
              ),
            ),
            FilledButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.renewLending,
              ),
            ),
            FilledButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.consultLendings,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
