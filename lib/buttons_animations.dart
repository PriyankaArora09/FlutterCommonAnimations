import 'package:flutter/material.dart';

class ButtonAnimationsPage extends StatelessWidget {
  const ButtonAnimationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Button Animations')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const AppliedTickButton(),
            const SizedBox(height: 15),
            const BouncyCartButton(),
            const SizedBox(height: 15),
            const CancelSlideButton(),
            const SizedBox(height: 15),
            const IconFlyButton(),
            const SizedBox(height: 15),
            const LoadingSuccessButton(),
            const SizedBox(height: 15),
            const FavoriteHeartButton(),
            const SizedBox(height: 15),
            const ToggleSwitchButton(),
            const SizedBox(height: 15),
            GradientButton(
              onPressed: () {},
              text: "gradient",
            ),
            const SizedBox(height: 15),
            const ProgressButton(),
            const SizedBox(height: 15),
            const MorphingProgressButton(),
            const SizedBox(height: 15),
            const FillTextButton(),
            const SizedBox(height: 15),
            const BarInsideButton(),
          ],
        ),
      ),
    );
  }
}

class AppliedTickButton extends StatefulWidget {
  const AppliedTickButton({super.key});

  @override
  State<AppliedTickButton> createState() => _AppliedTickButtonState();
}

class _AppliedTickButtonState extends State<AppliedTickButton> {
  bool applied = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() => applied = true);
        Future.delayed(const Duration(seconds: 2), () {
          setState(() => applied = false);
        });
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: applied
            ? const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check, key: ValueKey('check')),
                  SizedBox(width: 8),
                  Text('Applied', key: ValueKey('applied')),
                ],
              )
            : const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.done, key: ValueKey('done')),
                  SizedBox(width: 8),
                  Text('Apply', key: ValueKey('apply')),
                ],
              ),
      ),
    );
  }
}

class BouncyCartButton extends StatefulWidget {
  const BouncyCartButton({super.key});

  @override
  State<BouncyCartButton> createState() => _BouncyCartButtonState();
}

class _BouncyCartButtonState extends State<BouncyCartButton>
    with SingleTickerProviderStateMixin {
  bool added = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addToCart() {
    setState(() => added = true);
    _controller.forward(from: 0);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => added = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _addToCart,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 1.2).animate(
          CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
                added ? Icons.shopping_cart_checkout : Icons.add_shopping_cart),
            const SizedBox(width: 8),
            Text(added ? 'Added!' : 'Add to Cart'),
          ],
        ),
      ),
    );
  }
}

class CancelSlideButton extends StatefulWidget {
  const CancelSlideButton({super.key});

  @override
  State<CancelSlideButton> createState() => _CancelSlideButtonState();
}

class _CancelSlideButtonState extends State<CancelSlideButton> {
  bool cancelled = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () {
        setState(() => cancelled = true);
        Future.delayed(const Duration(seconds: 2),
            () => setState(() => cancelled = false));
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, anim) => SlideTransition(
            position:
                anim.drive(Tween(begin: const Offset(1, 0), end: Offset.zero)),
            child: child),
        child: Row(
          key: ValueKey(cancelled),
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(cancelled ? Icons.close : Icons.cancel),
            const SizedBox(width: 8),
            Text(cancelled ? 'Cancelled' : 'Cancel'),
          ],
        ),
      ),
    );
  }
}

class IconFlyButton extends StatefulWidget {
  const IconFlyButton({super.key});

  @override
  State<IconFlyButton> createState() => _IconFlyButtonState();
}

class _IconFlyButtonState extends State<IconFlyButton>
    with TickerProviderStateMixin {
  late final AnimationController _spinController;
  late final Animation<double> _rotation;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _rotation = Tween<double>(begin: 0, end: 2 * 3.1416).animate(
        CurvedAnimation(parent: _spinController, curve: Curves.easeInOut));

    _spinController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Reset to original
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() => isPressed = false);
            _spinController.reset();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    return _spinController.dispose();
  }

  void _onPressed() {
    setState(() => isPressed = true);
    _spinController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isPressed ? null : _onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey[700],
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _rotation,
            builder: (context, child) => Transform.rotate(
              angle: _rotation.value,
              child: const Icon(Icons.send, size: 20),
            ),
          ),
          const SizedBox(width: 8),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isPressed
                ? const SizedBox.shrink()
                : const Text("Send", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

class LoadingSuccessButton extends StatefulWidget {
  const LoadingSuccessButton({super.key});

  @override
  State<LoadingSuccessButton> createState() => _LoadingSuccessButtonState();
}

class _LoadingSuccessButtonState extends State<LoadingSuccessButton> {
  bool loading = false;
  bool success = false;

  void _simulateSubmit() {
    setState(() {
      loading = true;
      success = false;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        loading = false;
        success = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => success = false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _simulateSubmit,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: loading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : success
                ? const Icon(Icons.check_circle, color: Colors.white, size: 24)
                : const Text('Submit'),
      ),
    );
  }
}

class FavoriteHeartButton extends StatefulWidget {
  const FavoriteHeartButton({super.key});

  @override
  State<FavoriteHeartButton> createState() => _FavoriteHeartButtonState();
}

class _FavoriteHeartButtonState extends State<FavoriteHeartButton>
    with SingleTickerProviderStateMixin {
  bool liked = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    return _controller.dispose();
  }

  void _toggleLike() {
    setState(() => liked = !liked);
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 32,
      onPressed: _toggleLike,
      icon: ScaleTransition(
        scale: Tween(begin: 1.0, end: 1.3).animate(
          CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
        ),
        child: Icon(liked ? Icons.favorite : Icons.favorite_border,
            color: liked ? Colors.pink : Colors.white),
      ),
    );
  }
}

class ToggleSwitchButton extends StatefulWidget {
  const ToggleSwitchButton({super.key});

  @override
  State<ToggleSwitchButton> createState() => _ToggleSwitchButtonState();
}

class _ToggleSwitchButtonState extends State<ToggleSwitchButton> {
  bool on = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => on = !on),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60,
        height: 30,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: on ? Colors.lightGreen : Colors.grey[600],
        ),
        alignment: on ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const GradientButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class ProgressButton extends StatefulWidget {
  const ProgressButton({super.key});

  @override
  State<ProgressButton> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton> {
  bool isLoading = false;
  bool isSuccess = false;

  void _onPressed() async {
    setState(() {
      isLoading = true;
      isSuccess = false;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
      isSuccess = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isSuccess = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : _onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSuccess ? Colors.green : Colors.indigo,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : isSuccess
                ? const Icon(Icons.check,
                    key: ValueKey("check"), color: Colors.white)
                : const Text("Submit", key: ValueKey("text")),
      ),
    );
  }
}

class MorphingProgressButton extends StatefulWidget {
  const MorphingProgressButton({super.key});

  @override
  State<MorphingProgressButton> createState() => _MorphingProgressButtonState();
}

class _MorphingProgressButtonState extends State<MorphingProgressButton>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  bool isSuccess = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();
    return _controller.dispose();
  }

  void _onPressed() async {
    setState(() => isLoading = true);
    _controller.forward();

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
      isSuccess = true;
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() => isSuccess = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading || isSuccess ? null : _onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: isLoading || isSuccess ? 60 : 180,
        height: 50,
        decoration: BoxDecoration(
          color: isSuccess ? Colors.green : Colors.purple,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : isSuccess
                  ? const Icon(Icons.check, color: Colors.white)
                  : const Text("Save", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class FillTextButton extends StatefulWidget {
  const FillTextButton({super.key});

  @override
  State<FillTextButton> createState() => _FillTextButtonState();
}

class _FillTextButtonState extends State<FillTextButton>
    with SingleTickerProviderStateMixin {
  bool isFilling = false;
  late AnimationController _controller;
  late Animation<double> _fillPercent;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fillPercent = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    super.dispose();
    return _controller.dispose();
  }

  void _startFill() async {
    setState(() => isFilling = true);
    await _controller.forward();
    await Future.delayed(const Duration(seconds: 1));
    setState(() => isFilling = false);
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startFill,
      child: Container(
        width: 180,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.cyanAccent),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _fillPercent,
              builder: (context, child) {
                return FractionallySizedBox(
                  widthFactor: _fillPercent.value,
                  heightFactor: 1.0,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                );
              },
            ),
            Center(
              child: Text(
                "Download",
                style: TextStyle(
                  color: isFilling ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarInsideButton extends StatefulWidget {
  const BarInsideButton({super.key});

  @override
  State<BarInsideButton> createState() => _BarInsideButtonState();
}

class _BarInsideButtonState extends State<BarInsideButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool inProgress = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    super.dispose();
    return _controller.dispose();
  }

  void _startProgress() async {
    setState(() => inProgress = true);
    await _controller.forward();
    setState(() => inProgress = false);
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startProgress,
      child: Container(
        width: 200,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.teal[700],
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => FractionallySizedBox(
                widthFactor: _controller.value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.teal[300],
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                inProgress ? "Processing..." : "Upload",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
