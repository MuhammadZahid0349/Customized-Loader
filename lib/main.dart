import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customized Loader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Loader(),
    );
  }
}

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
            animation: _controller,
            builder: (context, widget) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 100,
                      child: Center(
                        child: Image.asset("assets/logo.png"),
                      ),
                    ),
                  ),
                  Center(
                    child: Transform.rotate(
                      angle: _controller.status == AnimationStatus.forward
                          ? (math.pi * 2) * _controller.value
                          : -(math.pi * 2) * _controller.value,
                      child: Container(
                        height: 150.0,
                        width: 150.0,
                        child: CustomPaint(
                          painter: LoaderCanvas(radius: _animation.value),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Transform.rotate(
                      angle: _controller.status == AnimationStatus.forward
                          ? (math.pi * 1) * _controller.value
                          : -(math.pi * 1) * _controller.value,
                      child: Container(
                        height: 180.0,
                        width: 180.0,
                        child: CustomPaint(
                          painter: LoaderCanvas(radius: _animation.value),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LoaderCanvas extends CustomPainter {
  double radius;
  LoaderCanvas({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint _arc = Paint()
      ..color = Color(0xff316395)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    Paint _circle = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    Offset _center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(_center, size.width / 2, _circle);
    canvas.drawArc(
        Rect.fromCenter(
            center: _center,
            width: size.width * radius,
            height: size.height * radius),
        math.pi / 4,
        math.pi / 2,
        false,
        _arc);
    canvas.drawArc(
        Rect.fromCenter(
            center: _center,
            width: size.width * radius,
            height: size.height * radius),
        -math.pi / 4,
        -math.pi / 2,
        false,
        _arc);
  }

  @override
  bool shouldRepaint(LoaderCanvas oldPaint) {
    return true;
  }
}
