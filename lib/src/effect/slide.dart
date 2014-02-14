/*!
 * Animation
 *
 * Copyright (C) 2012, Kai Sellgren
 * Licensed under the MIT License.
 * http://www.opensource.org/licenses/mit-license.php
 */

part of effect;

void slideOut(Element element, {String direction: 'right', duration: 1000, Easing easing}) {
  var wrapper = _createWrapper(element);
  wrapper.style
    ..overflow = 'hidden'
    ..width = '${element.clientWidth}px'
    ..height = '${element.clientHeight}px'
    ..position = 'relative';

  animate(element, properties: {'left': element.clientWidth});
}