import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';

class TextAnimationsDemo extends StatefulWidget {
  const TextAnimationsDemo({super.key});

  @override
  State<TextAnimationsDemo> createState() => _TextAnimationsDemoState();
}

class _TextAnimationsDemoState extends State<TextAnimationsDemo>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _scaleController;
  late final AnimationController _slideController;
  late final AnimationController _rotateController;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _rotateAnimation;

  String _typewriterText = "";
  final String _fullText = "This is a typewriter animation.";
  int _typewriterIndex = 0;
  Timer? _typewriterTimer;

  // Control flags
  String _activeAnimation = "";

  @override
  void initState() {
    super.initState();

    _fadeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    _scaleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _slideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );

    _rotateController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _rotateAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.easeInOut),
    );
  }

  void _startTypewriter() {
    _typewriterText = "";
    _typewriterIndex = 0;
    _typewriterTimer?.cancel();
    _typewriterTimer =
        Timer.periodic(const Duration(milliseconds: 80), (timer) {
      if (_typewriterIndex < _fullText.length) {
        setState(() {
          _typewriterText += _fullText[_typewriterIndex];
          _typewriterIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _showAnimation(String animationKey) {
    setState(() {
      _activeAnimation = animationKey;
      if (animationKey == "fade") _fadeController.forward(from: 0);
      if (animationKey == "scale") _scaleController.forward(from: 0);
      if (animationKey == "slide") _slideController.forward(from: 0);
      if (animationKey == "rotate") _rotateController.forward(from: 0);
      if (animationKey == "typewriter_manual") _startTypewriter();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    _rotateController.dispose();
    _typewriterTimer?.cancel();
    super.dispose();
  }

  Widget _buildButton(String label, String key) {
    return ElevatedButton(
      onPressed: () => _showAnimation(key),
      child: Text(label),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Text Animations Demo")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildButton("Fade Text", "fade"),
              if (_activeAnimation == "fade")
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text("This text fades in",
                      style: TextStyle(fontSize: 20)),
                ),
              _buildButton("Scale Text", "scale"),
              if (_activeAnimation == "scale")
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: const Text("This text scales in",
                      style: TextStyle(fontSize: 20)),
                ),
              _buildButton("Slide In Text", "slide"),
              if (_activeAnimation == "slide")
                SlideTransition(
                  position: _slideAnimation,
                  child: const Text("This text slides in",
                      style: TextStyle(fontSize: 20)),
                ),
              _buildButton("Rotate Text", "rotate"),
              if (_activeAnimation == "rotate")
                RotationTransition(
                  turns: _rotateAnimation,
                  child: const Text("This text rotates",
                      style: TextStyle(fontSize: 20)),
                ),
              _buildButton("Typewriter (Manual)", "typewriter_manual"),
              if (_activeAnimation == "typewriter_manual")
                Text(_typewriterText,
                    style:
                        const TextStyle(fontSize: 20, fontFamily: 'Courier')),
              _buildButton("Typewriter (Kit)", "typewriter"),
              if (_activeAnimation == "typewriter")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Typewriter Animation"),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('This is a typewriter animation',
                            textStyle: const TextStyle(fontSize: 24)),
                      ],
                      totalRepeatCount: 1,
                    ),
                  ],
                ),
              _buildButton("Fade (Kit)", "fade_kit"),
              if (_activeAnimation == "fade_kit")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Fade Animation"),
                    AnimatedTextKit(
                      animatedTexts: [
                        FadeAnimatedText('This is a fade animation',
                            textStyle: const TextStyle(fontSize: 24)),
                      ],
                      totalRepeatCount: 1,
                    ),
                  ],
                ),
              _buildButton("Scale (Kit)", "scale_kit"),
              if (_activeAnimation == "scale_kit")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Scale Animation"),
                    AnimatedTextKit(
                      animatedTexts: [
                        ScaleAnimatedText('Zoomed Text',
                            textStyle: const TextStyle(fontSize: 24)),
                      ],
                      totalRepeatCount: 1,
                    ),
                  ],
                ),
              _buildButton("Wavy Text", "wavy"),
              if (_activeAnimation == "wavy")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Wavy Animation"),
                    AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('Wavy Text',
                            textStyle: const TextStyle(fontSize: 24)),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ],
                ),
              _buildButton("Colorize Text", "colorize"),
              if (_activeAnimation == "colorize")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Colorize Animation"),
                    AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          'Colorful Text',
                          textStyle: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                          colors: [
                            Colors.purple,
                            Colors.blue,
                            Colors.yellow,
                            Colors.red
                          ],
                        ),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ],
                ),
              _buildButton("Shimmer Text", "shimmer"),
              if (_activeAnimation == "shimmer")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Shimmer Effect"),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.white,
                      child: const Text(
                        'Shimmer Text',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              _buildButton("Flicker Text", "flicker"),
              if (_activeAnimation == "flicker")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Flicker Animation"),
                    AnimatedTextKit(
                      animatedTexts: [
                        FlickerAnimatedText('Flicker Text',
                            textStyle: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ],
                ),
              _buildButton("Liquid Fill Text", "liquid"),
              if (_activeAnimation == "liquid")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Liquid Fill Animation"),
                    SizedBox(
                      height: 100,
                      child: TextLiquidFill(
                        text: 'LIQUID',
                        waveColor: Colors.blueAccent,
                        boxBackgroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                        boxHeight: 100,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
