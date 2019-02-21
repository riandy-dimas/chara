import 'package:flutter/material.dart';
import 'package:chara/draw/Draw.dart';
import 'package:chara/draw/PathPainter.dart';
import 'package:flutter/widgets.dart' hide Image;

class DrawState extends State<Draw> {
  bool _isFinished;

  @override
  void initState() {
    _isFinished = false;
    super.initState();
  }

  Size doFinish () {
    setState(() {
      _isFinished = true;
    });
    return context.size;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = new CustomPaint(
      willChange: true,
      painter: new PathPainter(
          widget.drawController.getPathContainer(),
          repaint: widget.drawController
      ),
    );
    child = new ClipRect(child:child);
    if(!_isFinished){
      child = new GestureDetector(
        child:child,
        onPanStart: onPanStart,
        onPanUpdate: onPanUpdate,
        onPanEnd: onPanEnd,
      );
    }
    return new Container(
      child: child,
      width: double.infinity,
      height: double.infinity,
    );
  }

  void onPanStart (DragStartDetails point) {
    Offset position = (context.findRenderObject() as RenderBox)
      .globalToLocal(point.globalPosition);
    widget.drawController.startDraw(position);
    widget.drawController.doNotifyListeners();
  }

  void onPanUpdate (DragUpdateDetails point) {
    Offset position = (context.findRenderObject() as RenderBox)
      .globalToLocal(point.globalPosition);
    widget.drawController.drawing(position);
    widget.drawController.doNotifyListeners();
  }

  void onPanEnd (DragEndDetails point) {
    widget.drawController.endDraw();
  }

}