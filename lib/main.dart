import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart'; // Import confetti package

void main() {
  runApp(const HeartbeatApp());
}

class HeartbeatApp extends StatelessWidget {
  const HeartbeatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HeartbeatScreen(),
    );
  }
}

class HeartbeatScreen extends StatefulWidget {
  @override
  _HeartbeatScreenState createState() => _HeartbeatScreenState();
}

class _HeartbeatScreenState extends State<HeartbeatScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
      lowerBound: 0.8,
      upperBound: 1.2,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(_controller);

    _confettiController = ConfettiController(
        duration: const Duration(seconds: 2)); // Initialize confetti
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: GestureDetector(
          onTap: () {
            if (_controller.isAnimating) {
              _controller.stop();
            } else {
              _controller.repeat(reverse: true);
            }
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation.value,
                child: Image.asset('assets/images/heart.png', width: 150),
              );
            },
          ),
        ),
      ),
    );
  }
}
