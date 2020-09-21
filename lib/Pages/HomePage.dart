import 'package:flutter/material.dart';
import 'package:atvFlutterExampleActivity/Providers/VideoState.dart';
import 'package:atvFlutterExampleActivity/Widgets/Cover.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    developer.log("Build home page", name: "Home Page");
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              child: Consumer<VideoState>(
                builder: (BuildContext context, VideoState videoState,
                    Widget child) {
                  return FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          // Backdrop gradient
          Positioned(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.grey.withOpacity(0.0),
                        Colors.pink[300],
                      ],
                      stops: [
                        0.0,
                        1.0
                      ])),
            ),
          ),

          // Header title and two buttons
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: <Widget>[
                Text(
                  'WIREWAX ITV',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.mic, color: Colors.white)),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.person, color: Colors.white)),
              ],
            ),
          ),

          // Media section: title and cover list
          Column(children: <Widget>[
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Text(
                    'Top Vision Movies',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Column(
                      children: <Widget>[
                        buildCoverList(context),
                      ],
                    )),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
