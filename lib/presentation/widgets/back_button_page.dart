import 'package:flutter/material.dart' show BackButton, Theme;
import 'package:flutter/widgets.dart'
    show
        BuildContext,
        Column,
        CrossAxisAlignment,
        EdgeInsets,
        Expanded,
        Padding,
        Row,
        SizedBox,
        StatelessWidget,
        Widget;
import 'package:go_router/go_router.dart' show GoRouterHelper;

import '../presentation.dart' show SpacingThemeExtension;

class BackButtonPage extends StatelessWidget {
  const BackButtonPage({
    super.key,
    this.title,
    this.child,
  });

  final Widget? title;
  final Widget? child;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: EdgeInsets.all(
          Theme.of(context).extension<SpacingThemeExtension>()!.large,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: Theme.of(context).extension<SpacingThemeExtension>()!.medium,
          children: <Widget>[
            Row(
              children: <Widget>[
                BackButton(
                  onPressed: context.pop,
                ),
                Expanded(child: title ?? const SizedBox.shrink()),
              ],
            ),
            Expanded(child: child ?? const SizedBox.shrink()),
          ],
        ),
      );
}
