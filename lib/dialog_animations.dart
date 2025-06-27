import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class DialogAnimationsPage extends StatelessWidget {
  const DialogAnimationsPage({super.key});

  void _showFadeDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'FadeDialog',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => const _DialogContent(),
      transitionBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  void _showScaleDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'ScaleDialog',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => const _DialogContent(),
      transitionBuilder: (_, animation, __, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: child,
        );
      },
    );
  }

  void _showSlideDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'SlideDialog',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => const _DialogContent(),
      transitionBuilder: (_, animation, __, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  void _showCombinedDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'CombinedDialog',
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => const _DialogContent(),
      transitionBuilder: (_, animation, __, child) {
        final curved =
            CurvedAnimation(parent: animation, curve: Curves.easeInOut);
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: curved,
            child: child,
          ),
        );
      },
    );
  }

  void _showRotateDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'RotateDialog',
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => const _DialogContent(),
      transitionBuilder: (_, animation, __, child) {
        return RotationTransition(
          turns: Tween<double>(begin: 0.75, end: 1).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  void showElasticDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => const _DialogContent(),
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: anim,
            curve: Curves.elasticOut,
          ),
          child: child,
        );
      },
    );
  }

  void showFlipDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (_, __, ___) => const _DialogContent(),
      transitionBuilder: (_, anim, __, child) {
        final rotate = Tween(begin: pi / 2, end: 0.0).animate(anim);
        return AnimatedBuilder(
          animation: rotate,
          builder: (_, child) {
            return Transform(
              transform: Matrix4.rotationY(rotate.value),
              alignment: Alignment.center,
              child: Opacity(opacity: anim.value, child: child),
            );
          },
          child: child,
        );
      },
    );
  }

  void showZoomOvershootDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => const _DialogContent(),
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: Tween(begin: 0.5, end: 1.0).animate(
            CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
          ),
          child: Opacity(opacity: anim.value, child: child),
        );
      },
    );
  }

  void showBackdropBlurDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => const _DialogContent(),
      transitionBuilder: (_, anim, __, child) {
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 5 * anim.value, sigmaY: 5 * anim.value),
          child: FadeTransition(opacity: anim, child: child),
        );
      },
    );
  }

  void showCornerPopDialog(BuildContext context, Alignment alignment) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => const _DialogContent(),
      transitionBuilder: (_, anim, __, child) {
        final offsetTween = Tween<Offset>(
          begin: Offset(alignment.x, alignment.y),
          end: Offset.zero,
        );
        return SlideTransition(
          position: offsetTween.animate(
            CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
          ),
          child: Opacity(opacity: anim.value, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialog Animations')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _showFadeDialog(context),
              child: const Text('Fade Dialog'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showScaleDialog(context),
              child: const Text('Scale Dialog'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showSlideDialog(context),
              child: const Text('Slide From Bottom Dialog'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showCombinedDialog(context),
              child: const Text('Fade + Scale Dialog'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showRotateDialog(context),
              child: const Text('Rotate Dialog'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => showElasticDialog(context),
              child: const Text('Elastic Dialog'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => showFlipDialog(context),
              child: const Text('Flip Dialog'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => showZoomOvershootDialog(context),
              child: const Text('Zoom overshoot Dialog'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => showBackdropBlurDialog(context),
              child: const Text('Backdrop Dialog Blur'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () =>
                  showCornerPopDialog(context, Alignment.bottomCenter),
              child: const Text('CornerProp Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Animated Dialog',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                  'This dialog uses a custom opening/closing animation.'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
