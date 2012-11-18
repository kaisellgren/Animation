/*!
 * Animation
 *
 * Copyright (C) 2012, Kai Sellgren
 * Licensed under the MIT License.
 * http://www.opensource.org/licenses/mit-license.php
 */

part of animation;

class EasingType {
  static final LINEAR = const EasingType._(0);
  static final QUADRATIC_EASY_IN = const EasingType._(1);
  static final QUADRATIC_EASY_OUT = const EasingType._(2);
  static final QUADRATIC_EASY_IN_OUT = const EasingType._(3);
  static final CUBIC_EASY_IN = const EasingType._(4);
  static final CUBIC_EASY_OUT = const EasingType._(5);
  static final CUBIC_EASY_IN_OUT = const EasingType._(6);
  static final QUARTIC_EASY_IN = const EasingType._(7);
  static final QUARTIC_EASY_OUT = const EasingType._(8);
  static final QUARTIC_EASY_IN_OUT = const EasingType._(9);
  static final QUINTIC_EASY_IN = const EasingType._(10);
  static final QUINTIC_EASY_OUT = const EasingType._(11);
  static final QUINTIC_EASY_IN_OUT = const EasingType._(12);
  static final SINUSOIDAL_EASY_IN = const EasingType._(13);
  static final SINUSOIDAL_EASY_OUT = const EasingType._(14);
  static final SINUSOIDAL_EASY_IN_OUT = const EasingType._(15);
  static final EXPONENTIAL_EASY_IN = const EasingType._(16);
  static final EXPONENTIAL_EASY_OUT = const EasingType._(17);
  static final EXPONENTIAL_EASY_IN_OUT = const EasingType._(18);
  static final CIRCULAR_EASY_IN = const EasingType._(19);
  static final CIRCULAR_EASY_OUT = const EasingType._(20);
  static final CIRCULAR_EASY_IN_OUT = const EasingType._(21);

  final int value;

  const EasingType._(this.value);
}