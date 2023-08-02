import 'dart:core';
import 'dart:math' as math;
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
// ignore: public_member_api_docs
class MyApp extends StatelessWidget {
  // ignore: public_member_api_docs
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
    );
  }
}

// ignore: public_member_api_docs
class MyHome extends StatefulWidget {
  // ignore: public_member_api_docs
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  Color? screenColor;
  final Shader linerGradient =
      const LinearGradient(colors: [Color(0xFF0E7AC8), Color(0xFFD15B18)])
          .createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 70.0));
   AnimationController? _animationController;
   Animation<double>? _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screenColor = Colors.white;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );
  }

  void onScreenTap() {
    setState(() {
      screenColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    });
    if (_animationController?.status == AnimationStatus.completed) {
      _animationController?.reverse();
    } else {
      _animationController?.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: onScreenTap,
          child: Container(
            color: screenColor,
            child: Center(
              child: AnimatedBuilder(
                  animation: _animation!,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation?.value,
                      child: Text('Hello there',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..shader = linerGradient
                                ..strokeWidth = 2
                                ..style = PaintingStyle.fill,),
                      ),
                    );
                  },
              ),
            ),
          ),),
    );
  }
  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }




}
