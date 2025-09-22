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

class AppShadows {
  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];
}
