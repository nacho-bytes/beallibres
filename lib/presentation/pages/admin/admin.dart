import 'package:flutter/material.dart' show ElevatedButton, Icons, Theme;
import 'package:flutter/widgets.dart'
    show
        Align,
        Alignment,
        BorderRadius,
        BoxFit,
        BuildContext,
        EdgeInsets,
        FittedBox,
        FractionallySizedBox,
        GridView,
        Icon,
        IconData,
        Padding,
        RoundedRectangleBorder,
        Stack,
        StatelessWidget,
        Text,
        VoidCallback,
        Widget;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;

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
        child: GridView.extent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing:
              Theme.of(context).extension<SpacingThemeExtension>()!.medium,
          mainAxisSpacing:
              Theme.of(context).extension<SpacingThemeExtension>()!.medium,
          children: <Widget>[
            _IconCard(
              title: AppLocalizations.of(context)!.users,
              icon: Icons.person,
              onPressed: () {},
            ),
            _IconCard(
              title: AppLocalizations.of(context)!.books,
              icon: Icons.menu_book,
              onPressed: () {},
            ),
            _IconCard(
              title: AppLocalizations.of(context)!.lendings,
              icon: Icons.bookmarks,
              onPressed: () {},
            ),
          ],
        ),
      );
}

class _IconCard extends StatelessWidget {
  const _IconCard({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Theme.of(context).extension<SpacingThemeExtension>()!.medium,
            ),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: Theme.of(context)
                    .extension<SpacingThemeExtension>()!
                    .medium,
                top: Theme.of(context)
                    .extension<SpacingThemeExtension>()!
                    .medium,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FractionallySizedBox(
                heightFactor: 0.8,
                widthFactor: 0.8,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Icon(
                    icon,
                    color:
                        Theme.of(context).colorScheme.onSurface.withAlpha(100),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
