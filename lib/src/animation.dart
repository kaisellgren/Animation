/*!
 * Animation
 *
 * Copyright (C) 2012, Kai Sellgren
 * Licensed under the MIT License.
 * http://www.opensource.org/licenses/mit-license.php
 */

part of animation;

abstract class Animation {
  int _duration = 500;

  /**
   * Returns the duration of this animation in milliseconds.
   */
  int get duration => _duration;

  /**
   * Sets the duration for this animation.
   *
   * It can be specified either in milliseconds or as an instance of [Duration].
   */
  set duration(duration) {
    if (duration is Duration)
      _duration = duration.inMilliseconds;

    if (duration is int)
      _duration = duration;
  }

  int _startTime;
  int _pausedAt;
  int _pausedFor = 0;
  bool _paused = false;
  bool _stopped = false;
  Tween tween = Tween.LINEAR;

  Future onComplete;
  Completer _onCompleteCompleter;

  Animation() {
    _onCompleteCompleter = new Completer();
    onComplete = _onCompleteCompleter.future;
  }

  /**
   * Pauses the animation.
   */
  pause() {
    _paused = true;
    _pausedAt = new Date.now().millisecondsSinceEpoch;
  }

  /**
   * Stops the animation and resets it to the beginning state.
   */
  stop() {
    _paused = false;
    _pausedAt = 0;
    _pausedFor = 0;
    _startTime = 0;
    _stopped = true;
  }

  /**
   * Completes the animation by setting it to the final state.
   */
  finish() {
    throw new NotImplementedException('');
  }

  /**
   * Fowards the animation by the given [duration].
   *
   * [duration] can either by in milliseconds or an instance of [Duration].
   *
   * If the current state forwarded by duration exceeds the total duration of the animation,
   * the animation will simply finish and be set to the final state.
   */
  forward(duration) {
    throw new NotImplementedException('');
  }

  /**
   * Delays the animation by [duration].
   *
   * [duration] can either by in milliseconds or an instance of [Duration].
   */
  delay(duration) {
    throw new NotImplementedException('');
  }

  /**
   * Runs the animation. If the animation was paused before, it will be resumed.
   */
  run() {
    _paused = false;
    _stopped = false;
  }
}