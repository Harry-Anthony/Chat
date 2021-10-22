import 'package:flutter/material.dart';

Tween t1 = Tween<Offset>(
  begin: const Offset(1.0, 0.0),
  end: const Offset(0.0, 0.0),
);

//transition ParallaxLeft
Tween t2 = Tween<Offset>(
  begin: const Offset(0.0, 0.0),
  end: const Offset(-0.6, 0.0),
);

//trasition slideLeft
Tween t3 = Tween<Offset>(
  begin: const Offset(0.0, 0.0),
  end: const Offset(-1.0, 0.0),
);

class PageTransition extends PageRouteBuilder {
  final Widget child;
  final Curve curve;
  final Alignment alignment;
  final Duration duration;

  PageTransition({
    Key key,
    @required this.child,
    this.curve = Curves.linear,
    this.alignment,
    this.duration = const Duration(milliseconds: 600),
  }) : super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return child;
      },
      transitionDuration: duration,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
        return TransitionEffect.createSlide(animationTween: t1, secondaryAnimationTween: t3)(curve, animation, secondaryAnimation, child);
      });
}

class TransitionEffect {

  static createSlide({Tween animationTween, Tween secondaryAnimationTween}) {
    return (Curve curve, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) => new SlideTransition(
      position: animationTween.animate(animation),
      child: new SlideTransition(
        position: secondaryAnimationTween.animate(secondaryAnimation),
        child: child,
      ),
    );
  }

}
