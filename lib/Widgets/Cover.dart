import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:atvFlutterExampleActivity/Service/VideoListService.dart';
import 'package:provider/provider.dart';
import 'package:atvFlutterExampleActivity/Providers/VideoState.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:developer' as developer;

class Cover extends StatefulWidget {
  const Cover({
    Key key,
    @required this.onTap,
    @required this.config,
    this.onFocus,
  }) : super(key: key);
  final Function onTap;
  final Function onFocus;
  final config;

  @override
  _CoverState createState() => _CoverState();
}

class _CoverState extends State<Cover> with SingleTickerProviderStateMixin {
  FocusNode _node;
  VideoState videoState;

  @override
  void initState() {
    _node = FocusNode();
    _node.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_node.hasFocus) {
      videoState.posterURL = widget.config.posterFrame;
    }
  }

  void _onTap() {
    developer.log('Cover onTap "${widget.config.title}"', name: 'Home Page');
    _node.requestFocus();
    if (widget.onTap != null) {
      widget.onTap();
    }
  }

  bool _onKey(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.select ||
          event.logicalKey == LogicalKeyboardKey.enter) {
        _onTap();
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    videoState = Provider.of<VideoState>(context);

    return Focus(
      autofocus: true,
      focusNode: _node,
      onKey: _onKey,
      child: Builder(builder: (context) {
        return buildCover(context);
      }),
    );
  }

  Widget buildCover(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        final FocusNode focusNode = Focus.of(context);
        final bool hasFocus = focusNode.hasFocus;
        return GestureDetector(
          onTap: _onTap,
          child: Container(
            // color: hasFocus ? Colors.pink : Colors.transparent,
            padding: hasFocus
                ? EdgeInsets.symmetric(vertical: 0, horizontal: 0)
                : EdgeInsets.symmetric(vertical: 20, horizontal: 2),
            child: Stack(children: <Widget>[
              Container(
                  child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: hasFocus ? 420 : 170,
                height: hasFocus ? 300 : 240,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget.config.posterFrame,
                  fit: BoxFit.cover,
                ),
              )),
              hasFocus
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        width: hasFocus ? 200 : 170,
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            widget.config.title,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ]),
          ),
        );
      },
    );
  }
}

Widget buildCoverList(BuildContext context) {
  return FutureProvider<String>(
//    create: (_) {
//      return "";
//    },
    child: Consumer<List<VideoModel>>(builder: (context, videoList, _) {
      if (videoList != null) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          height: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: videoList.length,
            itemBuilder: (BuildContext context, int index) {
              VideoModel videoConfigureData = videoList[index];
              VideoState videoState = Provider.of<VideoState>(context);
              return new Cover(
                  config: videoConfigureData,
                  onFocus: () {}, onTap: null,
              );
            },
          ),
        );
      }
      return Text('loading');
    }),
  );
}
