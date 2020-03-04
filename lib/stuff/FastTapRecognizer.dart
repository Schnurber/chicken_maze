import 'package:flutter/gestures.dart';

/// Faster Version of TapGestureRecognizer
class FastTapRecognizer extends PrimaryPointerGestureRecognizer {
  FastTapRecognizer({ Object debugOwner }) : super(deadline: Duration(milliseconds: 1), debugOwner: debugOwner);

  @override
  String get debugDescription => 'tap';

  GestureTapDownCallback onTapDown;

  @override
  void didExceedDeadline() {
    /// NOTHING...
  }

  @override
  void handlePrimaryPointer(PointerEvent event) {
    if (event is PointerUpEvent) {
      if (onTapDown != null)
        invokeCallback<void>('onTapDown', () { onTapDown(TapDownDetails(globalPosition: event.position)); });
    }
  }
}