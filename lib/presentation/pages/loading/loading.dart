import 'package:flutter/material.dart' show BuildContext, Center, CircularProgressIndicator, ColoredBox, StatelessWidget, Theme, Widget;

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => ColoredBox(
    color: Theme.of(context).scaffoldBackgroundColor,
    child: const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
