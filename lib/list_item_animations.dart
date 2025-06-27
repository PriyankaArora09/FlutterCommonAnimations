import 'package:flutter/material.dart';
import 'dart:math' as math;

class ListItemAnimationsDemo extends StatelessWidget {
  const ListItemAnimationsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = List.generate(10, (i) => 'Item ${i + 1}');

    return Scaffold(
      appBar: AppBar(title: const Text('List Item Animations')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildAnimatedList(
              context,
              title: 'Fade In Items',
              builder: (context, index, animation) => FadeTransition(
                opacity: animation,
                child: _listTile(items[index]),
              ),
            ),
            _buildAnimatedList(
              context,
              title: 'Slide From Left Items',
              builder: (context, index, animation) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: _listTile(items[index]),
              ),
            ),
            _buildAnimatedList(
              context,
              title: 'Scale In Items',
              builder: (context, index, animation) => ScaleTransition(
                scale: animation,
                child: _listTile(items[index]),
              ),
            ),
            _buildAnimatedList(
              context,
              title: 'Flip Y Items',
              builder: (context, index, animation) => AnimatedBuilder(
                animation: animation,
                builder: (context, child) => Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(math.pi * (1 - animation.value)),
                  alignment: Alignment.center,
                  child:
                      animation.value < 0.5 ? const SizedBox.shrink() : child,
                ),
                child: _listTile(items[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedList(
    BuildContext context, {
    required String title,
    required Widget Function(BuildContext, int, Animation<double>) builder,
  }) {
    final List<String> items = List.generate(6, (i) => 'Item ${i + 1}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        ...List.generate(
          items.length,
          (i) => TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 1500 + i * 100),
            builder: (context, value, child) => builder(
              context,
              i,
              AlwaysStoppedAnimation(value),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _listTile(String title) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(title: Text(title)),
    );
  }
}
