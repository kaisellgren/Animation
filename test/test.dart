import 'dart:html';
import 'dart:isolate';

import 'package:animation/animation.dart';

main() {
  var el = query('#box');

  var properties = {
    'opacity': 0.9,
    'left': 1000//,
    //'backgroundColor': '#fff'
  };

  animate(element: el, properties: properties, duration: 2000, easingType: EasingType.QUADRATIC_EASY_IN_OUT);

  /*var anim = new StyleAnimation(el)
    ..duration = 5000
    ..setProperties({
      'left': 1000,
      'top': 350
    })
    ..run();

  new Timer(2500, (Timer timer) {
    anim.pause();

    new Timer(2500, (Timer timer) {
      anim.run();
    });
  });*/

  /*var properties = {'left': 1000, 'top': 350};
  var anim = animate(element: el, properties: properties, duration: 5000);

  new Timer(2500, (Timer timer) {
    anim.stop();

    new Timer(2500, (Timer timer) {
      anim.run();
    });
  });*/
/*
  var anim = new StyleAnimation(el)
    ..duration = 1000
    ..setProperties({
      'left': 500,
      'top': 250
    });

  var anim2 = new StyleAnimation(el)
    ..duration = 500
    ..setProperties({
      'height': 250
    });

  var queue = new AnimationQueue()
    ..addAll([anim, anim2])
    ..run();*/
}