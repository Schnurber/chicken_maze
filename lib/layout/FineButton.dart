import 'package:flutter/material.dart';
import 'package:chicken_maze/layout/themeData.dart';

typedef CallBack = void Function();

class FineButton extends StatefulWidget {

  final CallBack onPressed;
  final String text;
  final bool  enabled;

  FineButton({@required this.onPressed, @required this.text, this.enabled = true});

  @override
  FineButtonState createState() {
    return new FineButtonState();
  }
}

class FineButtonState extends State<FineButton>
    with SingleTickerProviderStateMixin {

  Animation<double> _animation;
  AnimationController _animationController;
  double fontsize;
  double myPadding;
  double ts;
  
  @override
  void initState() {
    super.initState();
    fontsize = 12.0;
    myPadding = 30.0;
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: 500));
    _animation = Tween<double>(begin: 1.0, end: 2.0).animate(
        new CurvedAnimation(parent: _animationController, curve: Curves.elasticIn));
    _animation.addListener(() {
      setState(() {
        fontsize = 12.0 * _animation.value;
        myPadding = 30 * ts - (36.0 * ts * _animation.value - 36.0 * ts) / 2;
      });
    });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse().then((x) {
            widget.onPressed();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
   ts = getTextScale(context);
    var txt =  Text(widget.text, style: new TextStyle( fontSize: fontsize * ts, color: Colors.white));
    return Container(height: 56.0 * ts, child: Stack(
      fit: StackFit.loose,
      overflow: Overflow.visible,
      children: <Widget>[
          ButtonTheme(
            minWidth: 88.0 * ts *
                _animation
                    .value,
            height: 36.0 * ts *
                _animation
                    .value,
            child: RaisedButton(
              elevation: 1.0,
              padding: EdgeInsets.all(15 * ts),
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0 * ts)),
              child: txt,
              onPressed: this.widget.enabled ?? false ? () => _animationController.forward() : null
              ,
            ),
          ),
        ],
    ),
    );
  }
}