import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide TextStyle, FontWeight;
import 'package:flutter/rendering.dart' hide TextStyle, FontWeight;
import 'package:flutter/services.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/nums.dart';
import 'package:hub/__core__/extensions/theme.dart';
import 'package:hub/__core__/utils/math.dart';

class CircularKnobView extends LeafRenderObjectWidget {
  const CircularKnobView({
    super.key,
    required this.context,
    required this.progressText,
    required this.progressLabelText,
    this.progress = 0,
    this.onChanged,
  });

  final BuildContext context;
  final double progress;
  final ValueChanged<double>? onChanged;
  final String progressText;
  final String progressLabelText;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _CircularKnobRenderObject(
        progress: progress,
        context: context,
        progressText: progressText,
        progressLabelText: progressLabelText,
        onChanged: onChanged);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _CircularKnobRenderObject renderObject) {
    renderObject
      ..onChanged = onChanged
      ..progressText = progressText
      ..progressLabelText = progressLabelText
      ..progress = progress
      ..updateSweepAngle();
  }
}

class _CircularKnobRenderObject extends RenderBox {
  _CircularKnobRenderObject({
    required this.progress,
    required this.context,
    required this.progressText,
    required this.progressLabelText,
    this.onChanged,
  }) {
    _sweepAngle = interpolate(
        outputMin: minSweepAngle, outputMax: maxSweepAngle)(progress);
    drag = PanGestureRecognizer()
      ..onStart = onDragStart
      ..onUpdate = onDragUpdate
      ..onCancel = onDragCancel
      ..onEnd = onDragEnd;
  }

  double progress = 0;
  String progressText;
  String progressLabelText;
  ValueChanged<double>? onChanged;

  final BuildContext context;

  final _startAngle = 0.0.radians;
  var _sweepAngle = 120.radians;

  final minRadius = 100.0;
  final maxRadius = 250.0;

  final minSweepAngle = 0.0.radians;
  final maxSweepAngle = 300.0.radians;

  late Path knobPath;
  late Rect handleBounds;

  bool knobHandleSelected = false;

  late final DragGestureRecognizer drag;

  Offset currentDragOffset = Offset.zero;

  void updateSweepAngle() {
    _sweepAngle = interpolate(
        outputMin: minSweepAngle, outputMax: maxSweepAngle)(progress);
  }

  @override
  bool hitTestSelf(Offset position) {
    return knobPath.contains(position);
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    if (event is PointerDownEvent) {
      drag.addPointer(event);
    }
  }

  @override
  void performLayout() {
    final effectiveConstraints = constraints.enforce(
      BoxConstraints(
        minHeight: minRadius * 2,
        minWidth: minRadius * 2,
        maxHeight: maxRadius * 2,
        maxWidth: maxRadius * 2,
      ),
    );

    size = Size.square(effectiveConstraints.biggest.shortestSide);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    final bounds = offset & size;
    final radius = size.width / 2;
    final center = bounds.center;
    final angleOffset = -90.radians;

    // Draw background
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = this.context.theme.colorScheme.surfaceElevation1,
    );

    final knobThickness = size.width / 8;
    final knobPadding = knobThickness / 4;

    final startAngle = _startAngle + angleOffset;
    final endAngle = startAngle + _sweepAngle;
    final isLargeArc = _sweepAngle > 180.radians;

    final knobRadius = radius - knobPadding;
    final innerKnobRadius = knobRadius - knobThickness;

    final startOffset = toPolar(center, startAngle, knobRadius);
    final innerStartOffset = toPolar(center, startAngle, innerKnobRadius);

    final endOffset = toPolar(center, endAngle, knobRadius);
    final innerEndOffset = toPolar(center, endAngle, innerKnobRadius);
    final knobColor = this.context.theme.colorScheme.primaryContainer;
    final knobHandleColor = this.context.theme.colorScheme.onPrimaryContainer;

    // Draw track
    canvas
      ..drawCircle(
        center,
        knobRadius,
        Paint()..color = this.context.theme.colorScheme.surfaceElevation3,
      )
      ..drawCircle(
        center,
        innerKnobRadius,
        Paint()..color = this.context.theme.colorScheme.surfaceElevation1,
      );

    // Draw knob path
    knobPath = Path()
      ..moveTo(startOffset.dx, startOffset.dy)
      ..arcToPoint(
        endOffset,
        radius: Radius.circular(knobRadius),
        largeArc: isLargeArc,
      )
      ..arcToPoint(
        innerEndOffset,
        radius: Radius.circular(knobThickness / 2),
      )
      ..arcToPoint(
        innerStartOffset,
        radius: Radius.circular(innerKnobRadius),
        largeArc: isLargeArc,
        clockwise: false,
      )
      ..arcToPoint(
        startOffset,
        radius: Radius.circular(knobThickness / 2),
      );

    canvas.drawPath(
      knobPath,
      Paint()..color = knobColor,
    );

    // Draw knob handle
    final handleSize = Size.square(knobThickness);
    final handleSelectedStateColor =
        Color.lerp(knobHandleColor, knobColor, 0.5);
    handleBounds = Rect.fromCenter(
      center: Offset.lerp(endOffset, innerEndOffset, 0.5)!,
      width: handleSize.width,
      height: handleSize.height,
    );

    canvas.drawCircle(
      handleBounds.center,
      handleSize.radius,
      Paint()
        ..color =
            knobHandleSelected ? handleSelectedStateColor! : knobHandleColor,
    );

    // Draw Progress Text
    final textColor = this.context.theme.colorScheme.onSurface;
    final fontSize = innerKnobRadius / 2;
    final labelFontSize = innerKnobRadius / 6;
    final progressTextBound = center - Offset(0, innerKnobRadius / 6);
    final labelTextBound = center + Offset(0, innerKnobRadius / 3);

    _drawParagraph(
      canvas,
      progressText,
      offset: progressTextBound,
      color: textColor,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
    _drawParagraph(
      canvas,
      progressLabelText,
      offset: labelTextBound,
      color: textColor,
      fontSize: labelFontSize,
      fontWeight: FontWeight.bold,
    );

    super.paint(context, offset);
  }

  void onDragStart(DragStartDetails details) {
    final offset = globalToLocal(details.globalPosition);
    if (handleBounds.contains(offset)) {
      knobHandleSelected = true;
      currentDragOffset = offset;
    }
    markNeedsPaint();
  }

  void onDragUpdate(DragUpdateDetails details) {
    final diffInAngle = calculateDiffInAngle(
      currentDragOffset,
      currentDragOffset + details.delta,
    );
    final angle = normalizeSweepAngle(_sweepAngle.subtractAngle(diffInAngle));

    if (angle > minSweepAngle && angle < maxSweepAngle) {
      _sweepAngle = angle;
      currentDragOffset = details.localPosition;
      onAngleChange();
      markNeedsPaint();
    } else {
      onDragCancel();
    }
  }

  void onDragCancel() {
    knobHandleSelected = false;
    currentDragOffset = Offset.zero;
    markNeedsPaint();
  }

  void onDragEnd(DragEndDetails details) {
    onDragCancel();
  }

  void onAngleChange() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        HapticFeedback.selectionClick();
      },
    );

    final interpolator =
        interpolate(inputMax: maxSweepAngle, inputMin: minSweepAngle);

    onChanged?.call(interpolator(_sweepAngle));
  }

  Rect _drawParagraph(
    Canvas canvas,
    String text, {
    required Offset offset,
    required Color color,
    required double fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
  }) {
    final builder =
        ParagraphBuilder(ParagraphStyle(textAlign: TextAlign.center))
          ..pushStyle(TextStyle(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            letterSpacing: 1.2,
            fontFamily: fontFamily,
          ))
          ..addText(text);
    final paragraph = builder.build();
    final constraints = ParagraphConstraints(width: fontSize * text.length);
    final finalOffset = offset - Offset(constraints.width / 2, fontSize / 2);
    canvas.drawParagraph(paragraph..layout(constraints), finalOffset);
    return Rect.fromLTWH(finalOffset.dx, finalOffset.dy, paragraph.longestLine,
        paragraph.height);
  }

  double normalizeSweepAngle(double angle) {
    return max(minSweepAngle, min(angle, maxSweepAngle));
  }

  double calculateDiffInAngle(Offset prev, Offset current) {
    return toCartesian(prev, size.radius) - toCartesian(current, size.radius);
  }
}
