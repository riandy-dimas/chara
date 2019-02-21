import 'package:flutter/material.dart';
import 'package:chara/draw/DrawController.dart';
import 'package:chara/draw/DrawState.dart';

class Draw extends StatefulWidget {
  final DrawController drawController;

  Draw (DrawController drawController):
    this.drawController = drawController,
    super(key: new ValueKey<DrawController>(drawController));

  @override
  DrawState createState() => new DrawState();
}