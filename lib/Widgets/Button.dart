import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Button extends StatefulWidget {
  const Button({Key key, this.autoFocus, this.textData, this.onTap, this.fontSize, this.fontColor, this.width}) : super(key: key);
  final bool autoFocus;
  final String textData;
  final double fontSize;
  final Color fontColor;
  final double width;
  final onTap;
  // final route;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button>
    with SingleTickerProviderStateMixin {
  FocusNode _node;
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    _node = FocusNode();
    _node.addListener(_onFocusChange);
    super.initState();

    // Animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.5),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _node.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_node.hasFocus) {
    }
  }

  void _onTap() {
    widget.onTap();
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
    return Focus(
        focusNode: _node,
        onKey: _onKey,
        autofocus: this.widget.autoFocus != null ? true : false,
        child: Builder(builder: (context) => buildButton(context)));
  }

  Widget buildButton(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      final FocusNode focusNode = Focus.of(context);
      final bool hasFocus = focusNode.hasFocus;

      return Column(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 150),
            width: this.widget.width != null ? this.widget.width : 300,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: hasFocus ? Color(0xff4c8bf5) : Colors.transparent,
            ),
            child: InkWell(
              onTap: _onTap,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Center(
                  child: Text(
                    widget.textData,
                    style: TextStyle(
                        color: this.widget.fontColor != null ? this.widget.fontColor : Colors.black,
                        fontSize: this.widget.fontSize != null ? this.widget.fontSize : 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
