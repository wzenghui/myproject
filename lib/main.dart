import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WeightSave> weightSaves =new List();

  void _addWeightSave() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      weightSaves.add(new WeightSave(new DateTime.now(), new Random().nextInt
        (100).toDouble()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: new ListView(
          children:
           weightSaves.map((WeightSave weightSave){
             double difference = weightSaves.first == weightSave
                 ? 0.0
                 : weightSave.weight -
                 weightSaves[weightSaves.indexOf(weightSave) - 1].weight;
             return new WeightListItem(weightSave, difference);
           }
        ).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWeightSave,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class WeightSave {
  DateTime dateTime;
  double weight;

  WeightSave(this.dateTime, this.weight);
}
class WeightListItem extends StatelessWidget {
  final WeightSave weightSave;
  final double weightDifference;

  WeightListItem(this.weightSave, this.weightDifference);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(16.0),
      child: new Row(children: [
        new Expanded(
            child: new Column(children: [
              new Text(
                new DateFormat.yMMMMd().format(weightSave.dateTime),
                textScaleFactor: 0.9,
                textAlign: TextAlign.right,
              ),
              new Text(
                new DateFormat.EEEE().format(weightSave.dateTime),
                textScaleFactor: 0.8,
                textAlign: TextAlign.right,
                style: new TextStyle(
                  color: Colors.grey,
                ),
              ),
            ], crossAxisAlignment: CrossAxisAlignment.start)),
        new Expanded(
            child: new Text(
              weightSave.weight.toString(),
              textScaleFactor: 2.0,
              textAlign: TextAlign.center,
            )),
        new Expanded(
            child: new Text(
              weightDifference.toString(),
              textScaleFactor: 1.6,
              textAlign: TextAlign.right,
            )),
      ]),
    );
  }
}
