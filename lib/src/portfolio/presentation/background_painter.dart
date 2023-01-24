import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  BackgroundPainter({required Animation<double> animation})
      : secondPaint = Paint()
          ..color = const Color(0xffffa36c)
          ..style = PaintingStyle.fill,
        primaryPaint = Paint()
          ..color = const Color(0xfffdb827)
          ..style = PaintingStyle.fill,
        thirdPaint = Paint()
          ..color = const Color(0xffadb36e)
          ..style = PaintingStyle.fill,
        liquidAnim = CurvedAnimation(
          parent: animation,
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
        ),
        thirdColorAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.7,
            curve: Interval(0, 0.8, curve: SpringCurve()),
          ),
          reverseCurve: Curves.linear,
        ),
        primaryAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            // interval : 원래의 ~ 비율만큼
            0,
            0.8,
            curve: Interval(0, 0.9, curve: SpringCurve()),
          ),
          reverseCurve: Curves.easeInCirc,
        ),
        secondAnim = CurvedAnimation(
          parent: animation,
          curve: const SpringCurve(),
          reverseCurve: Curves.easeInCirc,
        ),
        super(repaint: animation); // repaint : listenable => paint 다시 call

  final Animation<double> liquidAnim;
  final Animation<double> secondAnim;
  final Animation<double> primaryAnim;
  final Animation<double> thirdColorAnim;

  final Paint secondPaint;
  final Paint primaryPaint;
  final Paint thirdPaint;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawPaint(Paint()..color = Palette.darkthirdColor); // 매번 new paint object 를 만들면 비효율적
    paintSecond(size, canvas);
    paintPrimary(size, canvas);
    paintThird(size, canvas);
  }

  void paintPrimary(Size size, Canvas canvas) {
    final path = Path();
    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(
        size.height / 4,
        size.height / 2,
        primaryAnim.value,
      )!,
    );
    _addPoint(
      path,
      [
        Point(
          size.width / 4,
          lerpDouble(size.height / 3, size.height * 3 / 4, liquidAnim.value)!,
        ),
        Point(
          size.width * 3 / 5,
          lerpDouble(size.height / 4, size.height / 2, liquidAnim.value)!,
        ),
        Point(
          size.width * 4 / 5,
          lerpDouble(size.height / 6, size.height / 3, primaryAnim.value)!,
        ),
        Point(
          size.width,
          lerpDouble(size.height / 5, size.height / 4, primaryAnim.value)!,
        ),
      ],
    );

    canvas.drawPath(path, primaryPaint);
  }

  void paintSecond(Size size, Canvas canvas) {
    final path = Path(); // paint 가 일어나야 하는 공간 정의
    path.moveTo(size.width, size.height / 2.3);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(0, size.height, secondAnim.value)!,
    );
    _addPoint(path, [
      Point(
        lerpDouble(0, size.width / 3, secondAnim.value)!,
        lerpDouble(
            0,
            size.height,
            secondAnim
                .value)!, // interpolation 방법 : lerpDouble(a,b,t) => a에서 b까지 t 시간동안
      ),
      Point(
        lerpDouble(size.width / 2, size.width / 4 * 3, liquidAnim.value)!,
        lerpDouble(size.height / 3, size.height / 4 * 3, liquidAnim.value)!,
      ),
      Point(
        size.width,
        lerpDouble(size.height / 3, size.height * 3 / 4, liquidAnim.value)!,
      ),
    ]);

    canvas.drawPath(path, secondPaint);
  }

  void paintThird(Size size, Canvas canvas) {
    if (thirdColorAnim.value > 0) {
      final path = Path();

      path.moveTo(size.width * 3 / 4, 0);
      path.lineTo(0, 0);
      path.lineTo(
        0,
        lerpDouble(0, size.height / 12, thirdColorAnim.value)!,
      );

      _addPoint(path, [
        Point(
          size.width / 7,
          lerpDouble(0, size.height / 6, liquidAnim.value)!,
        ),
        Point(
          size.width / 3,
          lerpDouble(0, size.height / 10, liquidAnim.value)!,
        ),
        Point(
          size.width / 3 * 2,
          lerpDouble(0, size.height / 8, liquidAnim.value)!,
        ),
        Point(
          size.width * 3 / 4,
          0,
        ),
      ]);

      canvas.drawPath(path, thirdPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // optimization method
    return true;
  }

  void _addPoint(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need three or more points to create a path');
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    path.quadraticBezierTo(
      points[points.length - 2].x,
      points[points.length - 2].y,
      points[points.length - 1].x,
      points[points.length - 1].y,
    );
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });

  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(math.pow(math.e, -t / a) * math.cos(t * w)) + 1).toDouble();
  }
}
