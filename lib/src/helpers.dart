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
 * You may specify a [duration] in milliseconds.
 *
 * By default, linear interpolation is used, but you may specify another [easingType] method to use.
 */
Animation animate(Element element, {int duration, EasingType easingType,
  Map<String, Object> properties, StepCallback onStep, bool paused}) {
  assert(element != null);
  final animation = new StyleAnimation(element);

  if (?properties) {
    animation.setProperties(properties);
  }

  if (?easingType) {
    animation.easingType = easingType;
  }

  if (?duration) {
    animation.duration = duration;
  }

  if (?onStep) {
    animation.onStep = onStep;
  }

  if (!?paused || paused == false) {
    animation.run();
  }

  return animation;
}

int get _nowMilliseconds => new Date.now().millisecondsSinceEpoch;
