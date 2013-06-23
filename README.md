Animation
==

Animate elements on a web page with Dart. Similar to jQuery's `animate()`.

## Features

* Simple and quick animations via the simple `animate()` function.
* More powerful `ElementAnimation` class for "low level" operations.
  * Pause, stop, resume, delay, forward, finish, reset.
* Queueing animations with `AnimationQueue`.
  * Clearing the queue.
  * Jumping between animations in the queue.
  * Supports the same pause, stop, resume, finish features as with `ElementAnimation`.
  * Manipulating the queue (remove, add).
* Run multiple animations at the same time (why not?).
* Uses `requestAnimationFrame()` instead of `setTimeout()` for optimal performance and smoother animations.
* Different easing options available (easy-in, ease-out, ease-in-out, linear) and with different algorithms (quadratic, sine, etc.).

## Changelog

#####Breaking changes with v0.5.20
- Renamed StyleAnimation to ElementAnimation. Reason: we now also animate non-styles such as scrollTop. The class was always HTMLElement-specific so the new name makes sense.
- Renamed `easingType` parameter for `animate()` to `easing` for better UX. Also renamed `EasingType` class to `Easing`.

## Missing features
##### Effects (fade, drop, slide, etc.)
Support for effects will come at some point.

##### Color and box/text-shadow animations
Currently you can't animate colors or shadows, this will change at some point.

## Examples

Let's assume we have this HTML:
```html
<div id="box" style="left: 100px;"></div>
```

#### Quick and simple

The simplest way to animate elements is to use the top-level helper function `animate()`:

```dart
import 'dart:html';
import 'package:animation/animation.dart');

main() {
  var el = query('#box');
  
  var properties = {
    'left': 1000,
    'top': 350
  };

  animate(el, properties: properties, duration: 5000);
}
```

#### Using `ElementAnimation` class

The `animate()` function uses `ElementAnimation` class internally. This class is more useful in "advanced" scenarios.
The following example will not run the animation directly, instead the animation will be instantiated first, and after 2 seconds we run the animation.

```dart
import 'dart:html';
import 'package:animation/animation.dart');

main() {
  var el = query('#box');
  
  var anim = new ElementAnimation(el)
    ..duration = 5000
    ..properties = {
      'left': 1000,
      'top': 350
    };

  // Let's wait 2 seconds before we run the animation for the sake of demoing this for you.
  new Timer(2000, anim.run);
}
```

#### Manipulating animations

You may manipulate animations in a few ways. In this example we will run an animation for 2.5 seconds, pause it for 2.5 seconds and then let it finish.

```dart
import 'dart:html';
import 'package:animation/animation.dart');

main() {
  var el = query('#box');
  
  var anim = new ElementAnimation(el)
    ..duration = 5000
    ..properties = {
      'left': 1000,
      'top': 350
    }
    ..run(); // Run immediately.

  // Let the animation run for 2.5 seconds, then we pause it.
  new Timer(2500, () {
    anim.pause();

    // Let it be paused for 2.5 seconds, then resume.
    new Timer(2500, anim.resume);
  });
}
```

#### `animate()` helper returns an `ElementAnimation`

The previous code could also be written using the `animate()` function if you will:

```dart
import 'dart:html';
import 'package:animation/animation.dart');

main() {
  var el = query('#box');
  
  // These two lines are different from previous example:
  var properties = {'left': 1000, 'top': 350};
  var anim = animate(element: el, properties: properties, duration: 5000);

  // Let the animation run for 2.5 seconds, then we pause it.
  new Timer(2500, () {
    anim.pause();

    // Let it be paused for 2.5 seconds, then resume.
    new Timer(2500, anim.resume);
  });
}
```

In case you wonder, `animate()` is just a simple helper function that produces an `ElementAnimation`. Use it if it works for you.
Note: using `animate()` will run the animation immediately after calling it. If you use `ElementAnimation`, you only construct a class instance
and you can start the animation later by calling `run()` on it.

#### Using `AnimationQueue` class

Sometimes you want to queue up a few animations. This can be done easily:

```dart
import 'dart:html';
import 'package:animation/animation.dart');

main() {
  var el = query('#box');
  
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
    ..run();
}
```

You may also `pause()` the queue, `finish()` it or `stop()` it. You can `add()` or `remove()` animations at any point.
You may also `jump()` to a specific position if you wanted to skip some animations for instance.

## License
This library is licensed under MIT.