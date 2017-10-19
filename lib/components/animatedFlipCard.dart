import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Card that flips on click and toggles [Widget] between first and second child
class AnimatedFlipCard extends StatefulWidget{
  AnimatedFlipCard({Key key, this.firstWidget, this.secondWidget, this.duration, this.direction}) : super(key: key);

  @required final Widget firstWidget;
  @required final Widget secondWidget;
  final Duration duration;
  final Axis direction;

  @override AnimatedCardState createState() => new AnimatedCardState();
}

class AnimatedCardState extends State<AnimatedFlipCard> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation<double> _firstWidgetAnimation;
  Animation<double> _secondWidgetAnimation;

  Duration _duration;
  Axis _direction;

  bool _showFirst = true;

  final Duration _defaultDuration = const Duration(milliseconds: 300);
  final Axis _defaultDirection = Axis.horizontal;

  @override
  void initState(){
    super.initState();

    /// These values are not required.
    /// Check if they are specified, if not give them default value.
    _duration = widget.duration ?? _defaultDuration;
    _direction = widget.direction ?? _defaultDirection;

    controller = new AnimationController(vsync: this, duration: _duration);

    // Have to init it with Tween and start animation in order to become visible
    _firstWidgetAnimation = new Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(new CurvedAnimation(
      parent: controller,
      curve: new Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
    ));

    _secondWidgetAnimation = new CurvedAnimation(
      parent: controller,
      curve: new Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _toggle,
      child: new Stack(
        children: <Widget>[
          _makeAnimatedBuilder(_firstWidgetAnimation, widget.firstWidget),
          _makeAnimatedBuilder(_secondWidgetAnimation, widget.secondWidget),
        ],
      ),
    );
  }

  /// Make Animated builder that will animate each child with it's own animation
  Widget _makeAnimatedBuilder(Animation<double> animation, Widget child){
    return new AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (BuildContext context, Widget child){
          return new Transform(
            transform: _getAnimatedTransform(animation),
            alignment: FractionalOffset.center,
            child: child,
          );
        }
    );
  }

  /// Get matrix animation transformation
  Matrix4 _getAnimatedTransform(Animation<double> animation){
    if(_direction == Axis.vertical){
      return new Matrix4.identity()..scale(1.0, animation.value, 1.0);
    }else{
      return new Matrix4.identity()..scale(animation.value, 1.0, 1.0);
    }
  }

  /// Toggle card state
  /// Animation will look good even if toggle is called but previous toggle is
  /// still running it's animation
  _toggle(){
    if (!_showFirst) {
      controller.reverse();
    } else {
      controller.forward();
    }

    _showFirst = !_showFirst;
  }
}