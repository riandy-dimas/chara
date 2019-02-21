import 'package:flutter/material.dart';
import 'package:chara/draw/PathContainer.dart';

class DrawController extends ChangeNotifier {
  static PathContainer _pathContainer;

  DrawController () {
    _pathContainer = new PathContainer();
  }

  void undo () {
    _pathContainer.undo();
    doNotifyListeners();
  }

  void eraseAll () {
    _pathContainer.eraseAll();
    doNotifyListeners();
  }

  void doNotifyListeners () {
    notifyListeners();
  }

  PathContainer getPathContainer () {
    return _pathContainer;
  }

  void startDraw (Offset position) {
    _pathContainer.startDraw(position);
  }

  void drawing (Offset position) {
    _pathContainer.drawing(position);
  }

  void endDraw () {
    _pathContainer.endDraw();
  }

}