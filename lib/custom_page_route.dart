import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

class CustomPageRoute {
  static PageRouteBuilder slideFromRight({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        final offsetTween =
            Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.ease));
        return SlideTransition(
            position: animation.drive(offsetTween), child: child);
      },
    );
  }

  static PageRouteBuilder slideFromLeft({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        final offsetTween =
            Tween(begin: const Offset(-1.0, 0.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.ease));
        return SlideTransition(
            position: animation.drive(offsetTween), child: child);
      },
    );
  }

  static PageRouteBuilder slideFromTop({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        final offsetTween =
            Tween(begin: const Offset(0, -1.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.ease));
        return SlideTransition(
            position: animation.drive(offsetTween), child: child);
      },
    );
  }

  static PageRouteBuilder fade({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static PageRouteBuilder scale({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        return ScaleTransition(scale: animation, child: child);
      },
    );
  }

  static PageRouteBuilder rotation({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        return RotationTransition(turns: animation, child: child);
      },
    );
  }

  static PageRouteBuilder slideFromBottomFade({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        final offsetTween =
            Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeOut));
        final opacityTween = Tween<double>(begin: 0.0, end: 1.0);
        return SlideTransition(
          position: animation.drive(offsetTween),
          child: FadeTransition(
              opacity: animation.drive(opacityTween), child: child),
        );
      },
    );
  }

  static PageRouteBuilder flipY({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final angle = animation.value * math.pi;
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              alignment: Alignment.center,
              child: animation.value <= 0.5
                  ? Container(color: Colors.transparent)
                  : child,
            );
          },
          child: child,
        );
      },
    );
  }

  static PageRouteBuilder flipX({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final angle = animation.value * math.pi;
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(angle),
              alignment: Alignment.center,
              child: animation.value <= 0.5
                  ? Container(color: Colors.transparent)
                  : child,
            );
          },
          child: child,
        );
      },
    );
  }

  static PageRouteBuilder rotateAndScale({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        return ScaleTransition(
          scale: animation,
          child: RotationTransition(turns: animation, child: child),
        );
      },
    );
  }

  static PageRouteBuilder bounce({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionDuration: const Duration(milliseconds: 600),
      transitionsBuilder: (_, animation, __, child) {
        final bounceCurve = Curves.elasticOut;
        return ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: bounceCurve),
            child: child);
      },
    );
  }

  static PageRouteBuilder elasticSlideFromBottom({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionDuration: const Duration(milliseconds: 800),
      transitionsBuilder: (_, animation, __, child) {
        final offsetTween =
            Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .chain(CurveTween(curve: Curves.elasticOut));
        return SlideTransition(
            position: animation.drive(offsetTween), child: child);
      },
    );
  }

  static PageRouteBuilder springSlide({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionDuration: const Duration(milliseconds: 800),
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(begin: const Offset(1, 0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutBack));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static PageRouteBuilder zoomOvershoot({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (_, animation, __, child) {
        final scaleTween = Tween<double>(begin: 0.8, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut));
        return ScaleTransition(
            scale: animation.drive(scaleTween), child: child);
      },
    );
  }

  static PageRouteBuilder blurFade({required Widget child}) {
    return PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => child,
      transitionsBuilder: (context, animation, _, child) {
        return Stack(
          children: [
            BackdropFilter(
              filter: animation.status == AnimationStatus.forward
                  ? ImageFilter.blur(
                      sigmaX: 5 * animation.value, sigmaY: 5 * animation.value)
                  : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                  color: Colors.black.withOpacity(0.2 * animation.value)),
            ),
            FadeTransition(opacity: animation, child: child),
          ],
        );
      },
    );
  }
}
