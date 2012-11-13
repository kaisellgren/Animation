/*!
 * Animation
 *
 * Copyright (C) 2012, Kai Sellgren
 * Licensed under the MIT License.
 * http://www.opensource.org/licenses/mit-license.php
 */

part of animation;

/**
 * Performs an animation on the given [element] with the given [properties].
 *
 * You may specify a [duration] either as an instance of [Duration] class or as an integer in milliseconds.
 *
 * By default, linear interpolation is used, but you may specify another [easing] method to use.
 */
animate({Element element, duration, Easing easing, Map<String, Object> properties}) {
  var animation;

  // Currently we just have StyleAnimation's, but in the future maybe others.
  if (?element)
    animation = new StyleAnimation(element);

  if (animation is Animation) {
    if (?properties)
      animation.setProperties(properties);

    if (?easing)
      animation.easing = easing;

    if (?duration)
      animation.duration = duration;

    animation.run();

    return animation;
  }

  throw new Exception('Could not perform the request animation. Did you specify an element to animate?');
}