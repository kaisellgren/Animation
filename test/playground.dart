import 'dart:html';
import 'dart:async';

import 'package:animation/animation.dart';

// This file is used to play around with the Animation lib to test things manually.

main() {
  var el = query('#box');

  //animate(document.body, duration: 1000, properties: {'scrollTop': 100});

  /*
  // The first animation moves the box.
  var anim = new ElementAnimation(el)
    ..duration = 1000
    ..properties = {
      'left': 500,
      'top': 250
    };

  // The second animation makes the box taller.
  var anim2 = new ElementAnimation(el)
    ..duration = 500
    ..properties = {
      'height': 250
    };

  // Create a queue, add both animations to it and run the queue.
  var queue = new AnimationQueue()
    ..addAll([anim, anim2])
    ..run();*/


  /*new AnimationQueue()
    ..addAll([
      animate(el, properties: {'opacity': 0.2}, duration: 1000, paused: true),
      animate(el, properties: {'opacity': 0.4}, duration: 1000, paused: true),
      animate(el, properties: {'opacity': 0.6}, duration: 1000, paused: true),
      animate(el, properties: {'opacity': 0.8}, duration: 1000, paused: true),
      animate(el, properties: {'opacity': 1.0}, duration: 1000, paused: true),
      animate(el, properties: {'opacity': 0.8}, duration: 1000, paused: true),
      animate(el, properties: {'opacity': 0.6}, duration: 1000, paused: true),
      animate(el, properties: {'opacity': 0.4}, duration: 1000, paused: true),
    ])
    ..repeat = -1
    ..interval = 1000
    ..run();*/

  /*var anim = new ElementAnimation(el)
    ..duration = 5000
    ..setProperties({
      'left': 1000,
      'top': 350
    })
    ..run();

  new Timer(const Duration(milliseconds: 2500), () {
    anim.pause();

    new Timer(const Duration(milliseconds: 2500), () {
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
  var anim = new ElementAnimation(el)
    ..duration = 1000
    ..setProperties({
      'left': 500,
      'top': 250
    });

  var anim2 = new ElementAnimation(el)
    ..duration = 500
    ..setProperties({
      'height': 250
    });

  var queue = new AnimationQueue()
    ..addAll([anim, anim2])
    ..run();*/
}