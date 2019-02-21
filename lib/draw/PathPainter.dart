import 'package:flutter/material.dart';
import 'package:chara/draw/PathContainer.dart';

class PathPainter extends CustomPainter {
  final PathContainer _paths;

  PathPainter (this._paths, {Listenable repaint}): super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    _paths.doDraw(canvas, size);
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) {
    return true;
  }
}
