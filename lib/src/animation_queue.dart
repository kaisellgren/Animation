/*!
 * Animation
 *
 * Copyright (C) 2012, Kai Sellgren
 * Licensed under the MIT License.
 * http://www.opensource.org/licenses/mit-license.php
 */

part of animation;

class AnimationQueue {
  int _position = 0;

  /**
   * Returns the current "position" -- the nth animation that is taking place.
   */
  int get position => _position;

  List<Animation> _queue = [];

  /**
   * Returns the number of animations remaining in the queue.
   *
   * This includes the currently running animation.
   */
  int get remaining => _queue.length - _position;

  /**
   * Adds the given animation to the queue.
   */
  add(Animation animation) {
    _queue.add(animation);
  }

  /**
   * Adds every animation in the collection to the queue.
   */
  addAll(Collection animations) {
    animations.forEach((animation) => _queue.add(animation));
  }

  /**
   * Clears the queue.
   *
   * If there's an animation occurring, it will complete.
   */
  clear() {
    _queue.clear();
    position = 0;
  }

  stop() {
    throw new NotImplementedException('');
  }

  pause() {
    throw new NotImplementedException('');
  }

  finish() {
    throw new NotImplementedException('');
  }

  /**
   * Removes the given animation from the queue.
   */
  remove(Animation animation) {
    var position = -1;

    // Determine the position of [animation] within the queue.
    for (var i = 0, length = _queue.length; i < length; i++) {
      if (_queue[i] == animation) {
        position = i;
        break;
      }
    }

    if (position >= 0)
      _queue.removeAt(position);
  }

  /**
   * Removes the animation at the given index.
   */
  removeAt(int index) {
    _queue.removeAt(index);
  }

  /**
   * Directly jumps to the nth animation in the queue.
   *
   * If there is currently an animation running, it will complete before this.
   */
  jump(int position) {
    _position = position;
  }

  /**
   * Runs the queue of animations.
   */
  run() {
    if (_position >= _queue.length) {
      // TODO: Fire an event.
    } else {
      Animation anim = _queue[_position];
      anim.onComplete.then((success) {
        _position++;
        run();
      });

      anim.run();
    }
  }
}