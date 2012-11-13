Animation
==

Animate elements on a web page with Dart.

## Examples

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
  </head>
  <body>
    <div id="box" style="left: 100px;"></div>

    <script type="application/dart" src="test.dart"></script>
    <script src="https://dart.googlecode.com/svn/branches/bleeding_edge/dart/client/dart.js"></script>
  </body>
</html>
```

```dart
import 'dart:html';
import 'package:animation/animation.dart');

main() {
  var el = query('#box');
  
  var properties = {
    'left': 1000,
    'top': 350
  };

  animate(element: el, properties: properties, duration: 5000);
}
```

## License
This library is licensed under MIT.