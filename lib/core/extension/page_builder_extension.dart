import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/enums/enum_utils.dart';

extension PageBuilder on Widget {
  CustomTransitionPage buildPage({PageAnimation pageAnimation = PageAnimation.none, LocalKey? key}) {
    return CustomTransitionPage(
      key: key,
      child: this,
      transitionDuration: _duration(pageAnimation),
      reverseTransitionDuration: _reverseDuration(pageAnimation),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: _curve(pageAnimation),
          reverseCurve: _reverseCurve(pageAnimation),
        );
        final curvedSecondaryAnimation = CurvedAnimation(
          parent: secondaryAnimation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        switch (pageAnimation) {
          case PageAnimation.slide:
          case PageAnimation.slideFromEnd:
            return _SlideFadeTransition(
              animation: curvedAnimation,
              begin: _horizontalStartOffset(context),
              child: child,
            );

          case PageAnimation.slideFromStart:
            return _SlideFadeTransition(
              animation: curvedAnimation,
              begin: -_horizontalStartOffset(context),
              child: child,
            );

          case PageAnimation.slideUp:
            return _SlideFadeTransition(animation: curvedAnimation, begin: const Offset(0, 0.12), child: child);

          case PageAnimation.fade:
            return FadeTransition(opacity: curvedAnimation, child: child);

          case PageAnimation.fadeScale:
            return _FadeScaleTransition(animation: curvedAnimation, child: child);

          case PageAnimation.zoom:
            return _ZoomFadeTransition(animation: curvedAnimation, child: child);

          case PageAnimation.sharedAxisHorizontal:
            return _SharedAxisTransition(
              animation: curvedAnimation,
              secondaryAnimation: curvedSecondaryAnimation,
              axis: Axis.horizontal,
              reverse: Directionality.of(context) == TextDirection.rtl,
              child: child,
            );

          case PageAnimation.sharedAxisVertical:
            return _SharedAxisTransition(
              animation: curvedAnimation,
              secondaryAnimation: curvedSecondaryAnimation,
              axis: Axis.vertical,
              child: child,
            );

          case PageAnimation.sharedAxisScale:
            return _SharedAxisScaleTransition(
              animation: curvedAnimation,
              secondaryAnimation: curvedSecondaryAnimation,
              child: child,
            );

          case PageAnimation.none:
            return _ModernPageTransition(animation: curvedAnimation, child: child);
        }
      },
    );
  }

  Offset _horizontalStartOffset(BuildContext context) {
    final textDirection = Directionality.of(context);
    return textDirection == TextDirection.rtl ? const Offset(-0.10, 0) : const Offset(0.10, 0);
  }

  Curve _curve(PageAnimation animation) {
    switch (animation) {
      case PageAnimation.zoom:
      case PageAnimation.sharedAxisScale:
        return Curves.easeOutBack;
      case PageAnimation.slide:
      case PageAnimation.slideFromEnd:
      case PageAnimation.slideFromStart:
      case PageAnimation.slideUp:
      case PageAnimation.fade:
      case PageAnimation.fadeScale:
      case PageAnimation.sharedAxisHorizontal:
      case PageAnimation.sharedAxisVertical:
      case PageAnimation.none:
        return Curves.easeOutCubic;
    }
  }

  Curve _reverseCurve(PageAnimation animation) {
    switch (animation) {
      case PageAnimation.zoom:
      case PageAnimation.sharedAxisScale:
        return Curves.easeInBack;
      case PageAnimation.slide:
      case PageAnimation.slideFromEnd:
      case PageAnimation.slideFromStart:
      case PageAnimation.slideUp:
      case PageAnimation.fade:
      case PageAnimation.fadeScale:
      case PageAnimation.sharedAxisHorizontal:
      case PageAnimation.sharedAxisVertical:
      case PageAnimation.none:
        return Curves.easeInCubic;
    }
  }

  Duration _duration(PageAnimation animation) {
    switch (animation) {
      case PageAnimation.fade:
        return const Duration(milliseconds: 240);
      case PageAnimation.slide:
      case PageAnimation.slideFromEnd:
      case PageAnimation.slideFromStart:
      case PageAnimation.slideUp:
        return const Duration(milliseconds: 320);
      case PageAnimation.fadeScale:
      case PageAnimation.zoom:
        return const Duration(milliseconds: 300);
      case PageAnimation.sharedAxisHorizontal:
      case PageAnimation.sharedAxisVertical:
      case PageAnimation.sharedAxisScale:
      case PageAnimation.none:
        return const Duration(milliseconds: 200);
    }
  }

  Duration _reverseDuration(PageAnimation animation) {
    switch (animation) {
      case PageAnimation.fade:
        return const Duration(milliseconds: 180);
      case PageAnimation.slide:
      case PageAnimation.slideFromEnd:
      case PageAnimation.slideFromStart:
      case PageAnimation.slideUp:
        return const Duration(milliseconds: 220);
      case PageAnimation.fadeScale:
      case PageAnimation.zoom:
        return const Duration(milliseconds: 200);
      case PageAnimation.sharedAxisHorizontal:
      case PageAnimation.sharedAxisVertical:
      case PageAnimation.sharedAxisScale:
      case PageAnimation.none:
        return const Duration(milliseconds: 150);
    }
  }
}

class _SlideFadeTransition extends StatelessWidget {
  const _SlideFadeTransition({required this.animation, required this.begin, required this.child});

  final Animation<double> animation;
  final Offset begin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final offsetAnimation = Tween<Offset>(begin: begin, end: Offset.zero).animate(animation);

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(position: offsetAnimation, child: child),
    );
  }
}

class _FadeScaleTransition extends StatelessWidget {
  const _FadeScaleTransition({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scaleAnimation = Tween<double>(begin: 0.96, end: 1).animate(animation);

    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(scale: scaleAnimation, child: child),
    );
  }
}

class _ZoomFadeTransition extends StatelessWidget {
  const _ZoomFadeTransition({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scaleAnimation = Tween<double>(begin: 0.88, end: 1).animate(animation);

    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(scale: scaleAnimation, child: child),
    );
  }
}

class _SharedAxisTransition extends StatelessWidget {
  const _SharedAxisTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.axis,
    required this.child,
    this.reverse = false,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Axis axis;
  final Widget child;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final incomingBegin = _offset(0.16);
    final outgoingEnd = _offset(-0.08);

    final incomingOffset = Tween<Offset>(begin: incomingBegin, end: Offset.zero).animate(animation);
    final outgoingOffset = Tween<Offset>(begin: Offset.zero, end: outgoingEnd).animate(secondaryAnimation);

    return SlideTransition(
      position: outgoingOffset,
      child: FadeTransition(
        opacity: ReverseAnimation(secondaryAnimation),
        child: SlideTransition(
          position: incomingOffset,
          child: FadeTransition(opacity: animation, child: child),
        ),
      ),
    );
  }

  Offset _offset(double value) {
    final resolvedValue = reverse ? -value : value;
    return axis == Axis.horizontal ? Offset(resolvedValue, 0) : Offset(0, resolvedValue);
  }
}

class _SharedAxisScaleTransition extends StatelessWidget {
  const _SharedAxisScaleTransition({required this.animation, required this.secondaryAnimation, required this.child});

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final incomingScale = Tween<double>(begin: 0.92, end: 1).animate(animation);
    final outgoingScale = Tween<double>(begin: 1, end: 1.04).animate(secondaryAnimation);

    return ScaleTransition(
      scale: outgoingScale,
      child: FadeTransition(
        opacity: ReverseAnimation(secondaryAnimation),
        child: ScaleTransition(
          scale: incomingScale,
          child: FadeTransition(opacity: animation, child: child),
        ),
      ),
    );
  }
}

class _ModernPageTransition extends StatelessWidget {
  const _ModernPageTransition({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final slideAnimation = Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero).animate(animation);

    final scaleAnimation = Tween<double>(begin: 0.985, end: 1).animate(animation);

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: slideAnimation,
        child: ScaleTransition(scale: scaleAnimation, child: child),
      ),
    );
  }
}
