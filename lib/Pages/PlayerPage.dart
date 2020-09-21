import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:atvFlutterExampleActivity/Pages/Player.dart';
import 'package:atvFlutterExampleActivity/Providers/VideoState.dart';
import 'dart:developer' as developer;
import 'package:provider/provider.dart';

class PlayerPage extends StatefulWidget {
  PlayerPage({Key key}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  bool _isPlaying = false;

  FocusNode _node;

  Player _controller = Player();
  ProgressBar _progressBar;

  void _onTap() {
    if (!_isPlaying) {
      _controller.play();
    } else {
      _controller.pause();
      VideoState videoState = Provider.of<VideoState>(context, listen: false);
      videoState.currentTime = _controller.getCurrentTime();
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(alignment: Alignment.bottomCenter, child: _progressBar),
      floatingActionButton: Focus(
        autofocus: true,
        focusNode: _node,
        child: Builder(
          builder: (BuildContext context) {
            final FocusNode focusNode = Focus.of(context);
            final bool hasFocus = focusNode.hasFocus;
            Color buttonColor = hasFocus ? Colors.pink : Colors.transparent;
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: buttonColor, width: 2.0),
                color: Color.fromRGBO(255, 255, 255, 0.15),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _onTap(),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 18.0,
                        color: buttonColor,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
