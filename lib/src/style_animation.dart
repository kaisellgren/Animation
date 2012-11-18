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
  Map<String, Object> currentProperties = {};
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
        var cssValue = style.getPropertyValue(key);

        // Different regular expressions to match number values.
        const numberWithUnitRegExp = const RegExp('^([0-9\.]+)([a-zA-Z]+)\$');
        const numberWithoutUnitRegExp = const RegExp('^([0-9\.]+)\$');
        const hexColorRegExp = const RegExp('^#([0-9]+)\$');
        const rgbRegExp = const RegExp('^rgb\(([0-9]{1,3}),\s*([0-9]{1,3}),\s*([0-9]{1,3})\)\$');
        const rgbaRegExp = const RegExp('^rgba\(([0-9]{1,3}),\s*([0-9]{1,3}),\s*([0-9]{1,3}),\s*([0-9\.]+)\)\$');
        const textShadowRegExp = const RegExp('^1px 1px 1px rgba()\$');

        var match = numberWithUnitRegExp.firstMatch(cssValue);

        // Number with a unit.
        if (match != null) {
          var value = match.group(1);
          var unit = match.group(2);

          fromProperties[key] = double.parse(value); // TODO: What about doubles?
          currentProperties[key] = double.parse(value);
          units[key] = unit;
        } else {
          var match = numberWithoutUnitRegExp.firstMatch(cssValue);

          // Number without a unit.
          if (match != null) {
            var value = match.group(1);

            fromProperties[key] = double.parse(value);
            currentProperties[key] = double.parse(value);
            units[key] = "";
          } else {
            throw new Exception('Cannot animate property "$key", because of its unsupported value "${cssValue}".');
          }
        }
      });

      completer.complete(true);
    });
  }

  stop() {
    super.stop();

    currentProperties = {};

    fromProperties.forEach((String key, int value) {
      element.style.setProperty(key, '${value}${units[key]}');
      currentProperties[key] = value;
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

    var currentTime = new Date.now().millisecondsSinceEpoch;

    // Reduce the time we have been paused for, to correct for the lost time.
    currentTime -= _pausedFor;

    // Calculate how much time we have left.
    var left = duration - (currentTime - _startTime);

    // Perform the animation.
    toProperties.forEach((String key, int value) {
      var intermediateValue;

      // If there's still time left, calculate the exact figures.
      if (left > 0) {
        var baseValue = fromProperties[key];      // The base/original value.
        var change    = value - baseValue;        // How much the values differ.
        var time      = currentTime - _startTime; // How much time has passed.

        // Calculate tween'ed value.
        intermediateValue = super._performEasing(time, duration, change, baseValue);

        // Clamps the intermediate value to be within value's range.
        if (value > 0 && intermediateValue > value)
          intermediateValue = value;
        if (value < 0 && intermediateValue < value)
          intermediateValue = value;
      }

      // If there is no time left, jump to the last value.
      else {
        intermediateValue = value;
      }

      currentProperties[key] = intermediateValue;

      element.style.setProperty(key, '${intermediateValue}${units[key]}');
    });

    // If we still have time left, go on.
    if (left > 0)
      window.requestAnimationFrame(_advance);
    else
      _onCompleteCompleter.complete(true);

    // TODO: Fire a "step" event!
  }
}