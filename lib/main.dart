import 'package:flutter/material.dart';
import 'package:chara/painter/Painter.dart';
import 'dart:typed_data';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chara',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
        primaryColor: Colors.pink.shade900,
        secondaryHeaderColor: Colors.pink.shade900,
      ),
      home: MyHomePage(title: 'Chara: Tulis Karakter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _finished;
  PainterController _controller;

  @override
  void initState() {
    super.initState();
    _finished=false;
    _controller=_newController();
  }

  PainterController _newController(){
    PainterController controller=new PainterController();
    controller.thickness=5.0;
    controller.backgroundColor=Colors.white;
    controller.strokeCap=StrokeCap.round;
    return controller;
  }

  void _doFinish (PictureDetails picture, BuildContext context) {
    _show(picture, context);
  }

  void _show(PictureDetails picture, BuildContext context){
      Navigator.of(context).push(
          new MaterialPageRoute(builder: (BuildContext context){
            return new Scaffold(
              appBar: new AppBar(
                title: const Text('Result'),
              ),
              body: new Container(
                  alignment: Alignment.center,
                  child:new FutureBuilder<Uint8List>(
                    future:picture.toPNG(),
                    builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot){
                      switch (snapshot.connectionState)
                      {
                        case ConnectionState.done:
                          if (snapshot.hasError){
                            return new Text('Error: ${snapshot.error}');
                          }else{
                            return Image.memory(snapshot.data);
                          }
                          break;
                        default:
                          return new Container(
                              child:new FractionallySizedBox(
                                widthFactor: 0.1,
                                child: new AspectRatio(
                                    aspectRatio: 1.0,
                                    child: new CircularProgressIndicator()
                                ),
                                alignment: Alignment.center,
                              )
                          );
                      }
                    },
                  )
              ),
            );
          })
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.undo),
            tooltip: 'Undo',
            onPressed: _controller.undo,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Reset',
            onPressed: _controller.startAgain,
          ),
        ],
      ),
      body: new Painter(_controller),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _doFinish(_controller.finish(), context),
        tooltip: 'Done',
        child: Icon(Icons.check),
        backgroundColor: Colors.pink.shade900,
        foregroundColor: Colors.white,
        mini: true,
      ),
    );
  }
}
