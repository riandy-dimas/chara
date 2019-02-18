import 'package:flutter/material.dart';
import 'Character.dart';
import 'CharacterPainter.dart';

class CharacterState extends State<Character> {
  List<Offset> _points = <Offset>[];

  void _resetPoints () {
    setState(() {
      _points = [];
    });
  }

  Widget build(BuildContext context) {
    return new Stack(
      children: [
        GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            RenderBox referenceBox = context.findRenderObject();
            Offset localPosition =
                referenceBox.globalToLocal(details.globalPosition);

            setState(() {
              _points = new List.from(_points)..add(localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
        ),
        CustomPaint(painter: new CharacterPainter(_points)),
        Positioned(
          child: FloatingActionButton(
            onPressed: _resetPoints,
            tooltip: 'Clear',
            child: Icon(Icons.refresh),
          ),
          bottom: 16,
          right: 16,
        )
      ],
    );
  }
}