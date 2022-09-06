import 'package:flutter/gestures.dart';

class CustomPanGestureRecognizer extends OneSequenceGestureRecognizer {
  CustomPanGestureRecognizer({
    required this.onPanDown,
    required this.onPanUpdate,
    required this.onPanEnd,
  });

  final  Function(PointerDownEvent event) onPanDown;
  final Function(PointerMoveEvent event) onPanUpdate;
  final Function(PointerUpEvent event) onPanEnd;

  @override
  void addPointer(PointerEvent event) {
    if (event is PointerDownEvent) {
      onPanDown(event);
      startTrackingPointer(event.pointer);
      resolve(GestureDisposition.accepted);
    } else {
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      onPanUpdate(event);
    }
    if (event is PointerUpEvent) {
      onPanEnd(event);
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  String get debugDescription => 'customPan';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
