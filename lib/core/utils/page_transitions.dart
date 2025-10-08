import 'package:flutter/material.dart';

/// Custom page route builder that provides smooth fade transitions
/// without the white flash that occurs with MaterialPageRoute
class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Duration duration;

  FadePageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) : super(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: duration,
          reverseTransitionDuration: duration,
        );
}

/// Custom page route builder that provides slide transitions
class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Duration duration;
  final Offset beginOffset;

  SlidePageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.beginOffset = const Offset(1.0, 0.0),
    RouteSettings? settings,
  }) : super(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: beginOffset,
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            );
          },
          transitionDuration: duration,
          reverseTransitionDuration: duration,
        );
}

/// Extension methods for easy navigation with custom transitions
extension NavigationExtensions on NavigatorState {
  /// Push with fade transition
  Future<T?> pushFade<T extends Object?>(Widget page) {
    return push<T>(FadePageRoute<T>(child: page));
  }

  /// Push replacement with fade transition
  Future<T?> pushReplacementFade<T extends Object?, TO extends Object?>(
    Widget page, {
    TO? result,
  }) {
    return pushReplacement<T, TO>(FadePageRoute<T>(child: page), result: result);
  }

  /// Push and remove until with fade transition
  Future<T?> pushAndRemoveUntilFade<T extends Object?>(
    Widget page,
    RoutePredicate predicate,
  ) {
    return pushAndRemoveUntil<T>(FadePageRoute<T>(child: page), predicate);
  }

  /// Push with slide transition
  Future<T?> pushSlide<T extends Object?>(
    Widget page, {
    Offset beginOffset = const Offset(1.0, 0.0),
  }) {
    return push<T>(SlidePageRoute<T>(
      child: page,
      beginOffset: beginOffset,
    ));
  }
}

/// Extension methods for BuildContext navigation
extension ContextNavigationExtensions on BuildContext {
  /// Push with fade transition
  Future<T?> pushFade<T extends Object?>(Widget page) {
    return Navigator.of(this).pushFade<T>(page);
  }

  /// Push replacement with fade transition
  Future<T?> pushReplacementFade<T extends Object?, TO extends Object?>(
    Widget page, {
    TO? result,
  }) {
    return Navigator.of(this).pushReplacementFade<T, TO>(page, result: result);
  }

  /// Push and remove until with fade transition
  Future<T?> pushAndRemoveUntilFade<T extends Object?>(
    Widget page,
    RoutePredicate predicate,
  ) {
    return Navigator.of(this).pushAndRemoveUntilFade<T>(page, predicate);
  }

  /// Push with slide transition
  Future<T?> pushSlide<T extends Object?>(
    Widget page, {
    Offset beginOffset = const Offset(1.0, 0.0),
  }) {
    return Navigator.of(this).pushSlide<T>(page, beginOffset: beginOffset);
  }
}
