import 'package:flutter/material.dart';
import 'package:flutter_animations/custom_page_route.dart';

class PageTransitionsDemo extends StatelessWidget {
  const PageTransitionsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Transitions Demo')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  CustomPageRoute.slideFromRight(
                      child: const SamplePage(title: 'Slide From Right')),
                ),
                child: const Text('Slide From Right'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  CustomPageRoute.slideFromLeft(
                      child: const SamplePage(title: 'Slide From Left')),
                ),
                child: const Text('Slide From Left'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  CustomPageRoute.fade(
                      child: const SamplePage(title: 'Fade Transition')),
                ),
                child: const Text('Fade'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  CustomPageRoute.scale(
                      child: const SamplePage(title: 'Scale Transition')),
                ),
                child: const Text('Scale (Zoom In)'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  CustomPageRoute.rotation(
                      child: const SamplePage(title: 'Rotation Transition')),
                ),
                child: const Text('Rotation'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  CustomPageRoute.slideFromBottomFade(
                      child: const SamplePage(title: 'Slide Bottom + Fade')),
                ),
                child: const Text('Slide From Bottom + Fade'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  CustomPageRoute.flipY(
                      child: const SamplePage(title: 'Flip Y 3D')),
                ),
                child: const Text('Flip 3D (Y-axis)'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  CustomPageRoute.bounce(
                      child: const SamplePage(title: 'Bounce Transition')),
                ),
                child: const Text('Bounce'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  CustomPageRoute.elasticSlideFromBottom(
                      child:
                          const SamplePage(title: 'Elastic Slide From Bottom')),
                ),
                child: const Text('Elastic Slide From Bottom'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  CustomPageRoute.zoomOvershoot(
                      child: const SamplePage(title: 'Zoom Overshoot')),
                ),
                child: const Text('Zoom Overshoot'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  CustomPageRoute.blurFade(
                      child: const SamplePage(title: 'Blur + Fade')),
                ),
                child: const Text('Blur + Fade'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SamplePage extends StatelessWidget {
  final String title;
  const SamplePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
