import 'package:flutter/material.dart';
import 'package:helo2/image.dart';

Widget getListView() {

    const textStyle = const TextStyle(
        fontWeight: FontWeight.bold,
    );

    return ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
            return Container(
                child: Column(
                    children: <Widget>[
                        new Row(
                            children: <Widget>[
                                new Container(
                                    padding: EdgeInsets.all(16),
                                    child: new CircleAvatar(
                                        backgroundImage: AssetImage("Resource/dog.jpeg"),
                                    ),
                                ),

                                new Text(
                                    "Andrew",
                                    textScaleFactor: 1.2,
                                    style: textStyle,
                                )
                            ],
                        ),

                        new GestureDetector(
                            onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) {
                                    return ImagePage();
                                }));
                            },
                            child: new Image.asset("Resource/timg.jpeg"),
                        ),

                        new Row(
                            children: <Widget>[
                                new Container(
                                    padding: EdgeInsets.all(16),
                                    child: new Row(
                                        children: <Widget>[
                                            new Container(
                                                padding: EdgeInsets.only(left: 10),
                                                child: new Icon(Icons.favorite_border),
                                            ),

                                            new Container(
                                                padding: EdgeInsets.only(left: 10),
                                                child: new Icon(Icons.crop_3_2),
                                            )

                                        ],
                                    )
                                ),
                            ],
                        ),

                        new Row(
                            children: <Widget>[
                                new Container(
                                    padding: EdgeInsets.all(16),
                                    child: new CircleAvatar(
                                        backgroundImage: AssetImage("Resource/dog.jpeg"),
                                    ),
                                ),


                                new Expanded(
                                    child: new Container(
                                        child: new TextField(
                                            decoration: InputDecoration(
                                                hintText: 'Add a comment...',
                                                border: InputBorder.none
                                            ),
                                        ),
                                    )
                                )
                            ],
                        ),
                    ],
                ),
            );
        },
    );
}

