/*!
 * Animation
 *
 * Copyright (C) 2012, Kai Sellgren
 * Licensed under the MIT License.
 * http://www.opensource.org/licenses/mit-license.php
 */

part of animation;

class Easing {
  static final LINEAR = const Easing._(0);
  static final EASE = const Easing._(1);
  static final EASE_IN = const Easing._(2);
  static final EASE_OUT = const Easing._(3);
  static final EASE_IN_OUT = const Easing._(4);
  static final CUBIC_BEZIER = const Easing._(5);

  final int value;

  const Easing._(this.value);
}