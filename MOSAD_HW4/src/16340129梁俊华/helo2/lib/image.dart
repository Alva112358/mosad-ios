import 'package:flutter/material.dart';


class ImagePage extends StatefulWidget {
    ImagePage({Key key, this.title}) : super(key: key);
    final String title;

    @override
    _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {

    @override
    Widget build(BuildContext context) {
        const textStyle = const TextStyle(
            color: Colors.black,
        );
        // TODO: implement build
        return Scaffold(
            appBar: new AppBar(
                title: Text(
                    "Andrew",
                    style: textStyle,
                ),
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(
                    color: Colors.black, //change your color here
                ),
            ),

            body: Container(
                child: Center(
                    child: Image.asset("Resource/timg.jpeg"),
                ),
            ),

        );
    }
}