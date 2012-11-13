/*!
 * Animation
 *
 * Copyright (C) 2012, Kai Sellgren
 * Licensed under the MIT License.
 * http://www.opensource.org/licenses/mit-license.php
 */

part of animation;

class StyleAnimation extends Animation {
  Element element;

  Map<String, Object> toProperties = {};
  Map<String, Object> fromProperties = {};
  Map<String, String> units = {};

  /**
   * Properties are set asynchronously (due to getComputedStyle()).
   *
   * We use futures to watch for when they have been set.
   */
  Future _propertiesReady;

  StyleAnimation(this.element) : super();

  /**
   * Sets the [properties] this animation affects.
   */
  setProperties(properties) {
    toProperties = properties;

    var completer = new Completer();
    _propertiesReady = completer.future;

    // Set "fromProperties".
    element.getComputedStyle("").then((CSSStyleDeclaration style) {
      toProperties.forEach((key, trash) {
        var CSSValue = style.getPropertyCSSValue(key);

        if (CSSValue.cssValueType == CSSPrimitiveValue.CSS_NUMBER) {
          // Retrieve the unit and value.
          const r = const RegExp('([0-9]+)([a-zA-Z]+)');
          var match = r.firstMatch(CSSValue.cssText);

          var value = match.group(1);
          var unit = match.group(2);

          fromProperties[key] = int.parse(value);
          units[key] = unit;
        } else {
          throw new Exception('Cannot animate field "$key", because the value type is not supported.');
        }
      });

      completer.complete(true);
    });
  }

  stop() {
    super.stop();

    fromProperties.forEach((String key, int value) {
      element.style.setProperty(key, '${value}px');
    });
  }

  run() {
    super.run();

    if (_propertiesReady is! Future)
      throw new Exception('You cannot run this animation without first setting properties to animate to.');

    // Start the animation when the properties are set.
    _propertiesReady.then((bool ready) {
      if (_paused) {
        _paused = false;
        _pausedFor += new Date.now().millisecondsSinceEpoch - _pausedAt;
      }
      else {
        _startTime = new Date.now().millisecondsSinceEpoch;
      }

      window.requestAnimationFrame(_advance);
    });
  }

  /**
   * Advances the animation by one step.
   */
  _advance(num highResTime) {
    if (_paused || _stopped)
      return;

    var now = new Date.now().millisecondsSinceEpoch;

    // Reduce the time we have been paused for, to correct for the lost time.
    now -= _pausedFor;

    // Determine amount of time left.
    var left = duration - (now - _startTime);

    var percentageComplete = 100 - (100 / (duration / left));

    toProperties.forEach((String key, int value) {
      // Calculate intermediate values.
      var intermediateValue = (value - fromProperties[key]) * percentageComplete / 100 + fromProperties[key];

      if (value > 0 && intermediateValue > value)
        intermediateValue = value;
      if (value < 0 && intermediateValue < value)
        intermediateValue = value;

      element.style.setProperty(key, '${intermediateValue}px');
    });

    if (left > 0) {
      window.requestAnimationFrame(_advance);
    } else {
      _onCompleteCompleter.complete(true);
    }

    // TODO: Fire a "step" event!
  }
}