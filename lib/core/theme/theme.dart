import 'package:flutter/material.dart';

class AppGradients extends ThemeExtension<AppGradients> {
  final Gradient headerGradient;
  final Gradient cardGradient;

  AppGradients({
    required this.headerGradient,
    required this.cardGradient,
  });

  @override
  ThemeExtension<AppGradients> copyWith({
    Gradient? headerGradient,
    Gradient? cardGradient,
  }) {
    return AppGradients(
      headerGradient: headerGradient ?? this.headerGradient,
      cardGradient: cardGradient ?? this.cardGradient,
    );
  }

  @override
  ThemeExtension<AppGradients> lerp(ThemeExtension<AppGradients>? other, double t) {
    if (other is! AppGradients) {
      return this;
    }
    return AppGradients(
      headerGradient: headerGradient,
      cardGradient: cardGradient,
    );
  }
}

class AppPalette extends ThemeExtension<AppPalette> {
  final Color sectionBg; // Top sections/background panels
  final Color cardBg; // Generic card background
  final Color cardBorder; // Generic card border
  final Color iconPrimary; // Primary icon color on light panels/cards
  final Color textPrimary; // Primary text on light panels/cards
  final Color textSecondary; // Secondary text on light panels/cards
  final Color dotActive; // Active indicator/dot color
  final Color dotInactive; // Inactive indicator/dot color

  const AppPalette({
    required this.sectionBg,
    required this.cardBg,
    required this.cardBorder,
    required this.iconPrimary,
    required this.textPrimary,
    required this.textSecondary,
    required this.dotActive,
    required this.dotInactive,
  });

  @override
  AppPalette copyWith({
    Color? sectionBg,
    Color? cardBg,
    Color? cardBorder,
    Color? iconPrimary,
    Color? textPrimary,
    Color? textSecondary,
    Color? dotActive,
    Color? dotInactive,
  }) {
    return AppPalette(
      sectionBg: sectionBg ?? this.sectionBg,
      cardBg: cardBg ?? this.cardBg,
      cardBorder: cardBorder ?? this.cardBorder,
      iconPrimary: iconPrimary ?? this.iconPrimary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      dotActive: dotActive ?? this.dotActive,
      dotInactive: dotInactive ?? this.dotInactive,
    );
  }

  @override
  ThemeExtension<AppPalette> lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      sectionBg: Color.lerp(sectionBg, other.sectionBg, t) ?? sectionBg,
      cardBg: Color.lerp(cardBg, other.cardBg, t) ?? cardBg,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t) ?? cardBorder,
      iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t) ?? iconPrimary,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      dotActive: Color.lerp(dotActive, other.dotActive, t) ?? dotActive,
      dotInactive: Color.lerp(dotInactive, other.dotInactive, t) ?? dotInactive,
    );
  }
}

class AppShadows {
  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];
}
