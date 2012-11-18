Animation
==

Animate elements on a web page with Dart. Similar to jQuery's `animate()`.

## Features

* Quick and simple animations via the simple `animate()` function.
* More powerful `StyleAnimation` class for "low level" operations.
  * Pause.
  * Stop.
  * Resume.
  * Delay.
  * Forward.
  * Finish.
  * Reset.
* Queueing animations with `AnimationQueue`.
  * Clear queue.
  * Jump between animations in the queue.
  * Same pause, stop, resume, finish features as with `StyleAnimation`.
  * Manipulate queue (remove, add).
* Run multiple animations at the same time (why not?).
* Uses `requestAnimationFrame()` instead of `setTimeout()` for optimal performance and smoother animations.
* Plenty of easing methods to use (different sorts of easing in/out/in-out).
  * Linear.
  * Quadratic.
  * Cubic.
  * Quartic.
  * Quintic.
  * Sinusoidal.
  * Exponential.
  * Circular.

## Missing features
##### Effects (fade, drop, slide, etc.)
Support for effects will come at some point.

##### Color and text-shadow animations
Currently you can't animate colors or text-shadow, this will change at some point.

## Examples

Let's assume we have this HTML:
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
  </head>
  <body>
    <div id="box" style="left: 100px;"></div>

    <script type="application/dart" src="test.dart"></script>
    <script src="https://dart.googlecode.com/svn/branches/bleeding_edge/dart/client/dart.js"></script>
  </body>
</html>
```

#### Quick and simple

The simplest way to animate elements directly is to use the helper top-level function `animate()`:

```dart
import 'dart:html';
import 'package:animation/animation.dart');

main() {
  var el = query('#box');
  
  var properties = {
    'left': 1000,
    'top': 350
  };

  animate(element: el, properties: properties, duration: 5000);
}
```

#### Using `StyleAnimation` class

The `animate()` function uses `StyleAnimation` class internally. This class is more useful in "advanced" scenarios.
The following example will not run the animation directly, instead the animation will be instantiated first, and after 2 seconds we run the animation.

```dart
import 'dart:html';
import 'package:animation/animation.dart');

main() {
  var el = query('#box');
  
  var anim = new StyleAnimation(el);
    ..duration = 5000
    ..setProperties({
      'left': 1000,
      'top': 350
    })

  // Let's wait 2 seconds before we run the animation, for the sake of demoing this for you.
  new Timer(2000, (Timer t) {
    anim.run(); // Here we go!
  });
}
```

#### Manipulating animations

You may manipulate animations in a few ways. In this example we will run an animation for 2.5 seconds, pause it for 2.5 seconds and then let it finish.

```dart
import 'dart:html';
import 'package:animation/animation.dart');

main() {
  var el = query('#box');
  
  var anim = new StyleAnimation(el)
    ..duration = 5000
    ..setProperties({
      'left': 1000,
      'top': 350
    })
    ..run(); // Run immediately.

  // Let the animation run for 2.5 seconds, then we pause it.
  new Timer(2500, (Timer timer) {
    anim.pause();

    // Let it be paused for 2.5 seconds, then resume.
    new Timer(2500, (Timer timer) {
      anim.run(); // Calling run again will resume the animation.
    });
  });
}
```

#### `animate()` helper returns a `StyleAnimation`

The previous code could also be written using the `animate()` function if you will:

```dart
import 'dart:html';
import 'package:animation/animation.dart');

main() {
  var el = query('#box');
  
  // These two lines are different:
  var properties = {'left': 1000, 'top': 350};
  var anim = animate(element: el, properties: properties, duration: 5000);

  // Let the animation run for 2.5 seconds, then we pause it.
  new Timer(2500, (Timer timer) {
    anim.pause();

    // Let it be paused for 2.5 seconds, then resume.
    new Timer(2500, (Timer timer) {
      anim.run(); // Calling run again will resume the animation.
    });
  });
}
```

In case you wonder, `animate()` is just a simple helper function that produces a `StyleAnimation`. Use it if it works for you.
Note: using `animate()` will run the animation immediately after calling it. If you use `StyleAnimation`, you only construct a class instance
and you can start the animation later by calling `run()` on it.

#### Using `AnimationQueue` class

Sometimes you want to queue up a few animations. This can be done easily:

```dart
import 'dart:html';
import 'package:animation/animation.dart');

main() {
  var el = query('#box');
  
  // The first animation moves the box.
  var anim = new StyleAnimation(el)
    ..duration = 1000
    ..setProperties({
      'left': 500,
      'top': 250
    });

  // The second animation makes the box taller.
  var anim2 = new StyleAnimation(el)
    ..duration = 500
    ..setProperties({
      'height': 250
    });

  // Create a queue, add both animations to it and run the queue.
  var queue = new AnimationQueue()
    ..addAll([anim, anim2])
    ..run();
}
```

You may also `pause()` the queue, `finish()` it or `stop()` it. You can `add()` or `remove()` animations at any point.
You may also `jump()` to a specific position if you wanted to skip some animations for instance.

## License
This library is licensed under MIT.