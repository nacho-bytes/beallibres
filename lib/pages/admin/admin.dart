import 'package:flutter/material.dart'
    show BuildContext, Column, EdgeInsets, FilledButton, Padding, StatelessWidget, Text, Theme, Widget, Wrap;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart' show GoRouterHelper;

import '../../router/routes.dart';
import '../../theme/spacing_theme_extension.dart' show SpacingThemeExtension;

export 'add_user/add_user.dart';

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
          AppLocalizations.of(context)!.hello('Nacho'),
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
