import 'dart:html';
import 'dart:isolate';

import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';

import 'package:animation/animation.dart';

main() {
  useHtmlEnhancedConfiguration();

  group('Easing', () {
    // Linear

    test('Linear start', () => expect(EasingEngine.linear(0, 1000, 1000, 0), 0));
    test('Linear middle', () => expect(EasingEngine.linear(100, 1000, 1000, 0), 100));
    test('Linear end', () => expect(EasingEngine.linear(1000, 1000, 1000, 0), 1000));

    // Quad

    test('Ease in quad start', () => expect(EasingEngine.easeInQuad(0, 1000, 1000, 0), 0));
    test('Ease in quad middle', () => expect(EasingEngine.easeInQuad(500, 1000, 1000, 0), 250));
    test('Ease in quad end', () => expect(EasingEngine.easeInQuad(1000, 1000, 1000, 0), 1000));

    test('Ease out quad start', () => expect(EasingEngine.easeOutQuad(0, 1000, 1000, 0), 0));
    test('Ease out quad middle', () => expect(EasingEngine.easeOutQuad(500, 1000, 1000, 0), 750));
    test('Ease out quad end', () => expect(EasingEngine.easeOutQuad(1000, 1000, 1000, 0), 1000));

    test('Ease in/out quad start', () => expect(EasingEngine.easeInOutQuad(0, 1000, 1000, 0), 0));
    test('Ease in/out quad middle', () => expect(EasingEngine.easeInOutQuad(500, 1000, 1000, 0), 500));
    test('Ease in/out quad end', () => expect(EasingEngine.easeInOutQuad(1000, 1000, 1000, 0), 1000));

    // Cubic

    test('Ease in Cubic start', () => expect(EasingEngine.easeInCubic(0, 1000, 1000, 0), 0));
    test('Ease in Cubic middle', () => expect(EasingEngine.easeInCubic(500, 1000, 1000, 0), 125));
    test('Ease in Cubic end', () => expect(EasingEngine.easeInCubic(1000, 1000, 1000, 0), 1000));

    test('Ease out Cubic start', () => expect(EasingEngine.easeOutCubic(0, 1000, 1000, 0), 0));
    test('Ease out Cubic middle', () => expect(EasingEngine.easeOutCubic(500, 1000, 1000, 0), 875));
    test('Ease out Cubic end', () => expect(EasingEngine.easeOutCubic(1000, 1000, 1000, 0), 1000));

    test('Ease in/out Cubic start', () => expect(EasingEngine.easeInOutCubic(0, 1000, 1000, 0), 0));
    test('Ease in/out Cubic middle', () => expect(EasingEngine.easeInOutCubic(500, 1000, 1000, 0), 500));
    test('Ease in/out Cubic end', () => expect(EasingEngine.easeInOutCubic(1000, 1000, 1000, 0), 1000));

    // Quartic

    test('Ease in Quartic start', () => expect(EasingEngine.easeInQuartic(0, 1000, 1000, 0), 0));
    test('Ease in Quartic middle', () => expect(EasingEngine.easeInQuartic(500, 1000, 1000, 0), 62.5));
    test('Ease in Quartic end', () => expect(EasingEngine.easeInQuartic(1000, 1000, 1000, 0), 1000));

    test('Ease out Quartic start', () => expect(EasingEngine.easeOutQuartic(0, 1000, 1000, 0), 0));
    test('Ease out Quartic middle', () => expect(EasingEngine.easeOutQuartic(500, 1000, 1000, 0), 937.5));
    test('Ease out Quartic end', () => expect(EasingEngine.easeOutQuartic(1000, 1000, 1000, 0), 1000));

    test('Ease in/out Quartic start', () => expect(EasingEngine.easeInOutQuartic(0, 1000, 1000, 0), 0));
    test('Ease in/out Quartic middle', () => expect(EasingEngine.easeInOutQuartic(500, 1000, 1000, 0), 500));
    test('Ease in/out Quartic end', () => expect(EasingEngine.easeInOutQuartic(1000, 1000, 1000, 0), 1000));

    // Quintic

    test('Ease in Quintic start', () => expect(EasingEngine.easeInQuintic(0, 1000, 1000, 0), 0));
    test('Ease in Quintic middle', () => expect(EasingEngine.easeInQuintic(500, 1000, 1000, 0), 31.25));
    test('Ease in Quintic end', () => expect(EasingEngine.easeInQuintic(1000, 1000, 1000, 0), 1000));

    test('Ease out Quintic start', () => expect(EasingEngine.easeOutQuintic(0, 1000, 1000, 0), 0));
    test('Ease out Quintic middle', () => expect(EasingEngine.easeOutQuintic(500, 1000, 1000, 0), 968.75));
    test('Ease out Quintic end', () => expect(EasingEngine.easeOutQuintic(1000, 1000, 1000, 0), 1000));

    test('Ease in/out Quintic start', () => expect(EasingEngine.easeInOutQuintic(0, 1000, 1000, 0), 0));
    test('Ease in/out Quintic middle', () => expect(EasingEngine.easeInOutQuintic(500, 1000, 1000, 0), 500));
    test('Ease in/out Quintic end', () => expect(EasingEngine.easeInOutQuintic(1000, 1000, 1000, 0), 1000));

    // Sine

    test('Ease in Sine start', () => expect(EasingEngine.easeInSine(0, 1000, 1000, 0), 0));
    test('Ease in Sine middle', () => expect(EasingEngine.easeInSine(500, 1000, 1000, 0), 292.89321881345245));
    test('Ease in Sine end', () => expect(EasingEngine.easeInSine(1000, 1000, 1000, 0).round(), 1000));

    test('Ease out Sine start', () => expect(EasingEngine.easeOutSine(0, 1000, 1000, 0), 0));
    test('Ease out Sine middle', () => expect(EasingEngine.easeOutSine(500, 1000, 1000, 0).round(), 707));
    test('Ease out Sine end', () => expect(EasingEngine.easeOutSine(1000, 1000, 1000, 0), 1000));

    test('Ease in/out Sine start', () => expect(EasingEngine.easeInOutSine(0, 1000, 1000, 0), 0));
    test('Ease in/out Sine middle', () => expect(EasingEngine.easeInOutSine(500, 1000, 1000, 0).round(), 500));
    test('Ease in/out Sine end', () => expect(EasingEngine.easeInOutSine(1000, 1000, 1000, 0), 1000));

    // Exp

    test('Ease in Exponential start', () => expect(EasingEngine.easeInExponential(0, 1000, 1000, 0).floor(), 0));
    test('Ease in Exponential middle', () => expect(EasingEngine.easeInExponential(500, 1000, 1000, 0), 31.25));
    test('Ease in Exponential end', () => expect(EasingEngine.easeInExponential(1000, 1000, 1000, 0), 1000));

    test('Ease out Exponential start', () => expect(EasingEngine.easeOutExponential(0, 1000, 1000, 0), 0));
    test('Ease out Exponential middle', () => expect(EasingEngine.easeOutExponential(500, 1000, 1000, 0), 968.75));
    test('Ease out Exponential end', () => expect(EasingEngine.easeOutExponential(1000, 1000, 1000, 0).ceil(), 1000));

    test('Ease in/out Exponential start', () => expect(EasingEngine.easeInOutExponential(0, 1000, 1000, 0).floor(), 0));
    test('Ease in/out Exponential middle', () => expect(EasingEngine.easeInOutExponential(500, 1000, 1000, 0), 500));
    test('Ease in/out Exponential end', () => expect(EasingEngine.easeInOutExponential(1000, 1000, 1000, 0).round(), 1000));

    // Circular

    test('Ease in Circular start', () => expect(EasingEngine.easeInCircular(0, 1000, 1000, 0), 0));
    test('Ease in Circular middle', () => expect(EasingEngine.easeInCircular(500, 1000, 1000, 0).round(), 134));
    test('Ease in Circular end', () => expect(EasingEngine.easeInCircular(1000, 1000, 1000, 0), 1000));

    test('Ease out Circular start', () => expect(EasingEngine.easeOutCircular(0, 1000, 1000, 0), 0));
    test('Ease out Circular middle', () => expect(EasingEngine.easeOutCircular(500, 1000, 1000, 0).round(), 866));
    test('Ease out Circular end', () => expect(EasingEngine.easeOutCircular(1000, 1000, 1000, 0), 1000));

    test('Ease in/out Circular start', () => expect(EasingEngine.easeInOutCircular(0, 1000, 1000, 0), -500));
    test('Ease in/out Circular middle', () => expect(EasingEngine.easeInOutCircular(500, 1000, 1000, 0), 500));
    test('Ease in/out Circular end', () => expect(EasingEngine.easeInOutCircular(1000, 1000, 1000, 0), 1000));
  });

  group('Animations', () {
    var el = new DivElement();
    animate(el, duration: 1000, easing: Easing.LINEAR, properties: {'left': 200});

  });
}