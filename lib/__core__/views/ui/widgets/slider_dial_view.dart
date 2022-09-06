import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide TextStyle, FontWeight;
import 'package:flutter/rendering.dart' hide TextStyle, FontWeight;
import 'package:flutter/services.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/theme.dart';
import 'package:hub/__core__/utils/math.dart';

class SliderDialView extends LeafRenderObjectWidget {
  const SliderDialView({
    super.key,
    required this.context,
    required this.thumbRadius,
    this.progress = 0,
    this.minTrackValue = 0,
    this.maxTrackValue = 100,
    this.trackStep = 20,
    this.stepPrefix = '',
    this.stepSuffix = '',
    this.onChanged,
  });

  final BuildContext context;
  final double progress;
  final double thumbRadius;

  final String stepPrefix;
  final String stepSuffix;

  final int maxTrackValue;
  final int minTrackValue;
  final int trackStep;

  final ValueChanged<double>? onChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SliderDialRenderObject(
      thumbRadius: thumbRadius,
      context: context,
      progress: progress,
      minTrackValue: minTrackValue,
      maxTrackValue: maxTrackValue,
      trackStep: trackStep,
      onChanged: onChanged,
      stepSuffix: stepSuffix,
      stepPrefix: stepPrefix,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _SliderDialRenderObject renderObject) {
    renderObject.updateRenderBox(thumbRadius: thumbRadius);
  }
}

class _SliderDialRenderObject extends RenderBox {
  _SliderDialRenderObject({
    required this.progress,
    required this.context,
    required this.thumbRadius,
    required this.minTrackValue,
    required this.maxTrackValue,
    required this.trackStep,
    required this.stepSuffix,
    required this.stepPrefix,
    this.onChanged,
  }) {
    sweep = interpolate()(progress);
    drag = PanGestureRecognizer()
      ..onStart = onDragStart
      ..onUpdate = onDragUpdate
      ..onCancel = onDragCancel
      ..onEnd = onDragEnd;
  }

  final BuildContext context;
  final double progress;

  String stepPrefix;
  String stepSuffix;

  double thumbRadius;

  ValueChanged<double>? onChanged;

  late int minTrackValue;
  late int maxTrackValue;
  late int trackStep;

  final double minSweep = 0;
  final double maxSweep = 1.0;
  late double sweep = 0.5;

  late Path knobTrackPath;
  late Path knobPath;

  late Rect knobTrackBound;

  late Rect handleBounds;

  bool knobHandleIsSelected = false;

  late final DragGestureRecognizer drag;

  late Offset currentDragOffset = Offset.zero;

  void updateRenderBox({
    double? thumbRadius,
    double? progress,
    int? minTrackValue,
    int? maxTrackValue,
    int? trackStep,
    String? stepPrefix,
    String? stepSuffix,
    ValueChanged<double>? onChanged,
  }) {
    this.thumbRadius = thumbRadius ?? this.thumbRadius;
    sweep = interpolate()(progress ?? this.progress);
    this.minTrackValue = minTrackValue ?? this.minTrackValue;
    this.maxTrackValue = maxTrackValue ?? this.maxTrackValue;
    this.trackStep = trackStep ?? this.trackStep;
    this.stepPrefix = stepPrefix ?? this.stepPrefix;
    this.stepSuffix = stepSuffix ?? this.stepSuffix;
    this.onChanged = onChanged ?? this.onChanged;
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  bool hitTestSelf(Offset position) {
    return knobTrackPath.contains(position);
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
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = thumbRadius * 6;
    final desiredSized = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSized);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    final bounds = offset & size;
    final knobColor = this.context.theme.colorScheme.primaryContainer;
    final knobHandleColor = this.context.theme.colorScheme.onPrimaryContainer;

    // Draw background
    canvas.drawRRect(
      RRect.fromRectAndRadius(bounds, const Radius.circular(16)),
      Paint()..color = this.context.theme.colorScheme.surfaceElevation1,
    );

    // Draw knob track
    final startOffset =
        bounds.topLeft + Offset(thumbRadius * 2, thumbRadius * 2);
    final innerStartOffset = startOffset + Offset(0, thumbRadius);

    final endOffset =
        bounds.topRight + Offset(-thumbRadius * 2, thumbRadius * 2);
    final innerEndOffset = endOffset + Offset(0, thumbRadius);

    knobTrackBound = Rect.fromPoints(startOffset, innerEndOffset);

    knobTrackPath = Path()
      ..moveTo(startOffset.dx, startOffset.dy)
      ..lineTo(endOffset.dx, endOffset.dy)
      ..arcToPoint(innerEndOffset, radius: Radius.circular(thumbRadius / 2))
      ..lineTo(innerStartOffset.dx, innerStartOffset.dy)
      ..arcToPoint(startOffset, radius: Radius.circular(thumbRadius / 2));

    canvas.drawPath(
      knobTrackPath,
      Paint()..color = this.context.theme.colorScheme.surfaceElevation5,
    );

    // Draw knob path
    final knobOffset = startOffset + ((endOffset - startOffset) * sweep);
    final innerKnobOffset =
        innerStartOffset + ((innerEndOffset - innerStartOffset) * sweep);

    knobPath = Path()
      ..moveTo(startOffset.dx, startOffset.dy)
      ..lineTo(knobOffset.dx, knobOffset.dy)
      ..arcToPoint(innerKnobOffset, radius: Radius.circular(thumbRadius / 2))
      ..lineTo(innerStartOffset.dx, innerStartOffset.dy)
      ..arcToPoint(startOffset, radius: Radius.circular(thumbRadius / 2));

    ///

    canvas.drawPath(
      knobPath,
      Paint()..color = knobColor,
    );

    // Draw knob handle
    final handleSize = Size.square(thumbRadius * 2);
    final handleSelectedStateColor =
        Color.lerp(knobHandleColor, knobColor, 0.5);

    handleBounds = Rect.fromCenter(
        center: Offset.lerp(knobOffset, innerKnobOffset, 0.5)!,
        width: handleSize.width,
        height: handleSize.height);

    canvas.drawCircle(
        handleBounds.center,
        thumbRadius,
        Paint()
          ..color = knobHandleIsSelected
              ? handleSelectedStateColor!
              : knobHandleColor);

    // Draw text dials

    final textColor = this.context.theme.colorScheme.secondary;
    final highlightedTextColor = this.context.theme.colorScheme.primary;
    final fontSize = thumbRadius / 1.1;
    final textOffset = bounds.centerLeft + Offset(0, thumbRadius * 1.5);

    for (var i = minTrackValue; i <= maxTrackValue; i += trackStep) {
      final position = interpolate(
        inputMin: minTrackValue * 1.0,
        inputMax: maxTrackValue * 1.0,
        outputMin: startOffset.dx,
        outputMax: endOffset.dx,
      )(i * 1.0);

      final behindKnob = knobOffset.dx.floorToDouble() >= position;

      _drawParagraph(
        canvas,
        '$stepPrefix$i$stepSuffix',
        offset: textOffset + Offset(position, 0),
        color: behindKnob ? highlightedTextColor : textColor,
        fontSize: fontSize,
      );
    }

    super.paint(context, offset);
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

  void onDragStart(DragStartDetails details) {
    final offset = globalToLocal(details.globalPosition);
    if (handleBounds.contains(offset)) {
      knobHandleIsSelected = true;
      currentDragOffset = offset;
    }
    markNeedsPaint();
  }

  void onDragUpdate(DragUpdateDetails details) {
    final position = details.localPosition;

    if (position.dx >= knobTrackBound.centerLeft.dx &&
        position.dx <= knobTrackBound.centerRight.dx) {
      sweep = interpolate(
          inputMin: knobTrackBound.centerLeft.dx,
          inputMax: knobTrackBound.centerRight.dx)(position.dx);
      currentDragOffset = details.localPosition;
      onDisplacementChange();
      markNeedsPaint();
    } else {
      onDragCancel();
    }
  }

  void onDragCancel() {
    knobHandleIsSelected = false;
    currentDragOffset = Offset.zero;
    markNeedsPaint();
  }

  void onDragEnd(DragEndDetails details) {
    onDragCancel();
  }

  void onDisplacementChange() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        HapticFeedback.selectionClick();
      },
    );

    final interpolator = interpolate(inputMax: maxSweep, inputMin: minSweep);

    onChanged?.call(interpolator(sweep));
  }
}
