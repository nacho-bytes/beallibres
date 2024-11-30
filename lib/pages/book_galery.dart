import 'dart:math';

import 'package:flutter/material.dart' show BoxFit, BuildContext, GridView, Image, SliverGridDelegateWithFixedCrossAxisCount, StatelessWidget, Widget;

/// A widget that displays a grid of book covers.
class BookGalery extends StatelessWidget {
  /// Creates a widget that displays a grid of book covers.
  /// 
  /// The [key] is optional and defaults to `null`.
  const BookGalery({
    super.key,
  });

  @override
  Widget build(final BuildContext context) =>
    GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 50,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (final BuildContext context, final int index) => Image.asset(
        'assets/images/book-cover-placeholder.png',
        width: (100 + Random().nextInt(50) - Random().nextInt(50)).toDouble(),	
        height:(160 + Random().nextInt(100) - Random().nextInt(100)).toDouble(),
        fit: BoxFit.fitWidth,
      ),
    );
}
