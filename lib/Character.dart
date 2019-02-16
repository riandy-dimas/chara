import 'package:flutter/material.dart';
import 'CharacterPainter.dart';

class Character extends StatefulWidget {
  CharacterState createState() => new CharacterState();
}

class CharacterState extends State<Character> {
  List<Offset> _points = <Offset>[];

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
        CustomPaint(painter: CharacterPainter(_points), size: Size.infinite),
      ],
    );
  }
}