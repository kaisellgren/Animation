/*!
 * Animation
 *
 * Copyright (C) 2012, Kai Sellgren
 * Licensed under the MIT License.
 * http://www.opensource.org/licenses/mit-license.php
 */

part of animation;

class StyleAnimation extends Animation {
  final Map<String, Object> fromProperties = {};
  final Map<String, Object> currentProperties = {};
  final Map<String, String> units = {};

  final Element element;

  Map<String, Object> toProperties = {};

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
  }

  /**
   * Calculates the current style and sets from properties.
   *
   * This should be called just before the animation starts.
   */
  _setFromProperties() {
    var completer = new Completer();
    _propertiesReady = completer.future;

    // Set "fromProperties".
    CssStyleDeclaration  style = element.getComputedStyle("");

      toProperties.forEach((key, trash) {
        var cssValue = style.getPropertyValue(key);

        // Different regular expressions to match number values.
        var numberWithUnitRegExp = new RegExp('^(-?[0-9\.]+)([a-zA-Z]+)\$');
        var numberWithoutUnitRegExp = new RegExp('^(-?[0-9\.]+)\$');

        /*
        TODO: Make use of these formats.
        var hexColorRegExp = new RegExp('^#([0-9]+)\$');
        var rgbRegExp = new RegExp('^rgb\(([0-9]{1,3}),\s*([0-9]{1,3}),\s*([0-9]{1,3})\)\$');
        var rgbaRegExp = new RegExp('^rgba\(([0-9]{1,3}),\s*([0-9]{1,3}),\s*([0-9]{1,3}),\s*([0-9\.]+)\)\$');
        var textShadowRegExp = new RegExp('^1px 1px 1px rgba()\$');
         */

        var match = numberWithUnitRegExp.firstMatch(cssValue);

        // Number with a unit.
        if (match != null) {
          var value = match.group(1);
          var unit = match.group(2);

          fromProperties[key] = double.parse(value);
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

  }

  stop() {
    super.stop();

    currentProperties.clear();

    _setFromProperties();

    _propertiesReady.then((ready) {
      fromProperties.forEach((String key, value) {
        element.style.setProperty(key, '${value}${units[key]}');
        currentProperties[key] = value;
      });
    });
  }

  run() {
    // We have to remember that an animation may be created, but not ran immediately.
    // If it's ran later on, the initial styles may be different, so we defer loading of properties until run() is called.

    if (_propertiesReady is! Future) {
      _setFromProperties();
    }

    // Start the animation when the properties are set.
    _propertiesReady.then((bool ready) {
      if (_paused) {
        var now = _nowMilliseconds;

        _paused = false;
        _pausedFor += now - _pausedAt;
      }

      // Set the start time if first time.
      if (_startTime == null)
        _startTime = _nowMilliseconds;

      window.requestAnimationFrame(_advance);
    });

    super.run();
  }

  /**
   * Advances the animation by one step.
   */
  _advance(num highResTime) {
    if (_paused || _stopped) {
      return;
    }

    var currentTime = _nowMilliseconds;

    // Reduce the time we have been paused for, to correct for the lost time.
    currentTime -= _pausedFor;

    // Calculate how much time we have left.
    var left = duration - (currentTime - _startTime);

    if (_onStepController.hasListener) {
      var percentage = 100 - (100 / (duration / left));

      // Clamp.
      if (percentage > 100) {
        percentage = 100;
      } else if (percentage < 0) {
        percentage = 0;
      }

      _onStepController.add({
        'animation': this,
        'percentage': percentage
      });
    }

    // Perform the animation.
    toProperties.forEach((String key, value) {
      var intermediateValue;

      // If there's still time left, calculate the exact figures.
      if (left > 0) {
        var baseValue = fromProperties[key];      // The base/original value.
        var change    = value - baseValue;        // How much the values differ.
        var time      = currentTime - _startTime; // How much time has passed.
        // Calculate tween'ed value.
        intermediateValue = super._performEasing(time, duration, change, baseValue);

        // Clamps the intermediate value to be within value's range.
        if (baseValue > value) {
          if (value > 0 && intermediateValue < value)
            intermediateValue = value;
          if (value < 0 && intermediateValue > value)
            intermediateValue = value;
        } else {
          if (value > 0 && intermediateValue > value)
            intermediateValue = value;
          if (value < 0 && intermediateValue < value)
            intermediateValue = value;
        }
      }

      // If there is no time left, jump to the last value.
      else {
        intermediateValue = value;
      }

      currentProperties[key] = intermediateValue;
      element.style.setProperty(key, '${intermediateValue}${units[key]}');
    });

    // If we still have time left, go on.
    if (left > 0) {
      window.requestAnimationFrame(_advance);
    } else {
      _onCompleteController.add(null);
    }

    // TODO: Fire a "step" event!
  }
}
