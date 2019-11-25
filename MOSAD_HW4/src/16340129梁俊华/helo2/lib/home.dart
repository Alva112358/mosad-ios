import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helo2/list.dart';

class MyHomePage extends StatefulWidget {
    MyHomePage({Key key, this.title}) : super(key: key);
    final String title;

    @override
    _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    static const platform = const MethodChannel('samples.flutter.io/battery');
    String _batteryLevel = "100 %";
    // static const MethodChannel methodChannel = MethodChannel('samples.flutter.io/battery');

    Future<void> _getBatteryLevel() async {
        String batteryLevel;
        try {
            final int result = await platform.invokeMethod('getBatteryLevel');
            batteryLevel = '$result %';
            print(batteryLevel);
        } on PlatformException catch (e) {
            batteryLevel = "20 %";
            print(e);
        }

        setState(() {
            _batteryLevel = batteryLevel;
        });
    }

    @override
    Widget build(BuildContext context) {
        const textStyle = const TextStyle(
            color: Colors.black,
        );

        return Scaffold(
            appBar: AppBar(
                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Text(
                    "Helo",
                    style: textStyle,
                ),
                centerTitle: true,
                leading: IconButton(
                    icon: Icon(Icons.camera_alt),
                    padding: EdgeInsets.only(left: 12),
                    // disabledColor: Colors.black,
                    color: Colors.black,
                    onPressed: () {},
                ),
                backgroundColor: Colors.white,
                actions: <Widget>[
                    new Row(
                        children: <Widget>[
                            new Container(
                                padding: EdgeInsets.only(right: 0),
                                child: new IconButton(
                                    icon: new Icon(Icons.battery_unknown),
                                    color: Colors.black,
                                    onPressed: _getBatteryLevel
                                ),
                            ),

                            new Container(
                                padding: EdgeInsets.only(right: 12),
                                child: new Text(
                                    _batteryLevel,
                                    textScaleFactor: 1.1,
                                    style: textStyle,
                                ),
                            )
                        ],
                    )
                ],
            ),

            body: getListView(),

            bottomNavigationBar: new BottomAppBar(
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,

                    children: <Widget>[
                        new IconButton(icon: new Icon(Icons.home), onPressed: () {}),
                        new IconButton(icon: new Icon(Icons.search, color: Colors.grey), onPressed: () {}),
                        new IconButton(icon: new Icon(Icons.add_box, color: Colors.grey), onPressed: () {}),
                        new IconButton(icon: new Icon(Icons.favorite, color: Colors.grey), onPressed: () {}),
                        new IconButton(icon: new Icon(Icons.account_box, color: Colors.grey), onPressed: () {})
                    ],
                ),
            ),
        );
    }
}