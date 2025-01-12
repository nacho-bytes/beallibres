import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart' show ThemeExtension, immutable;

@immutable
class SpacingThemeExtension extends ThemeExtension<SpacingThemeExtension> {
  const SpacingThemeExtension({
    required this.small,
    required this.medium,
    required this.large,
  });

  final double small;
  final double medium;
  final double large;

  @override
  SpacingThemeExtension copyWith({
    final double? small,
    final double? medium,
    final double? large,
  }) => SpacingThemeExtension(
    small: small ?? this.small,
    medium: medium ?? this.medium,
    large: large ?? this.large,
  );

  @override
  SpacingThemeExtension lerp(final ThemeExtension<SpacingThemeExtension>? other, final double t) {
    if (other is! SpacingThemeExtension) {
      return this;
    }
    return SpacingThemeExtension(
      small: lerpDouble(small, other.small, t)!,
      medium: lerpDouble(medium, other.medium, t)!,
      large: lerpDouble(large, other.large, t)!,
    );
  }
}
