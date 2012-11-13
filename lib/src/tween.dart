/*!
 * Animation
 *
 * Copyright (C) 2012, Kai Sellgren
 * Licensed under the MIT License.
 * http://www.opensource.org/licenses/mit-license.php
 */

part of animation;

class Tween {
  static final LINEAR = const Tween._(0);
  static final EASE = const Tween._(1);
  static final EASE_IN = const Tween._(2);
  static final EASE_OUT = const Tween._(3);
  static final EASE_IN_OUT = const Tween._(4);
  static final CUBIC_BEZIER = const Tween._(5);

  final int value;

  const Tween._(this.value);
}