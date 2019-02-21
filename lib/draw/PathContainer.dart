import 'package:flutter/material.dart';
import 'dart:ui';

class PathContainer {
  List<MapEntry<Path, Paint>> _paths;
  Paint _newPaint = new Paint()
                        ..color = Colors.black
                        ..strokeCap = StrokeCap.round
                        ..strokeWidth = 5.0;
  Paint _background;
  bool _isDragging;

  PathContainer () {
    _paths = new List<MapEntry<Path, Paint>>();
    _background = new Paint()
                      ..color = Color.fromARGB(255, 255, 255, 255);
    _isDragging = false;
  }

  void doDrag () {
    _isDragging = true;
  }

  void endDrag () {
    _isDragging = false;
  }

  void undo () {
    if (!_isDragging) {
      _paths.removeLast();
    }
  }

  void eraseAll () {
    if (!_isDragging) {
      _paths.clear();
    }
  }

  void startDraw (Offset point) {
    if (!_isDragging) {
      Path _newPath = new Path();
      final x = point.dx;
      final y = point.dy;

      doDrag();
      _newPath.moveTo(x, y);
      _paths.add(new MapEntry<Path, Paint>(_newPath, _newPaint));
    }
  }

  void drawing (Offset point) {
    if (_isDragging) {
      Path _newPath = new Path();
      final x = point.dx;
      final y = point.dy;
      
      _newPath.lineTo(x, y);
    }
  }

  void endDraw () {
    endDrag();
  }

  void doDraw (Canvas canvas, Size size) {
    canvas.drawRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height), _background);
    for (MapEntry<Path,Paint> path in _paths) {
      canvas.drawPath(path.key, path.value);
    }
  }
}