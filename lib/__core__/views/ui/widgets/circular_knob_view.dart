import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart' hide TextStyle, FontWeight;
import 'package:flutter/services.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/nums.dart';
import 'package:hub/__core__/extensions/theme.dart';
import 'package:hub/__core__/utils/custom_pan_recogniser.dart';
import 'package:hub/__core__/utils/math.dart';

class CircularKnobView extends StatefulWidget {
  const CircularKnobView({
    super.key,
    this.progress = 0.0,
    required this.progressText,
    required this.labelText,
    this.onChanged,
  });

  final ValueChanged<double>? onChanged;
  final String progressText;
  final String labelText;
  final double progress;

  @override
  State<CircularKnobView> createState() => _CircularKnobViewState();
}

class _CircularKnobViewState extends State<CircularKnobView> {
  late _CircularKnobPainter painter;

  late bool knobHandleSelected = false;

  late Offset currentDragOffset = Offset.zero;

  double sweepAngle = 0.0.radians;

  double progress = 0.0;

  @override
  void initState() {
    progress = widget.progress;
    setupPainter();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CircularKnobView oldWidget) {
    if (widget.progress != oldWidget.progress ||
        widget.progressText != oldWidget.progressText ||
        widget.labelText != oldWidget.labelText ||
        widget.onChanged != oldWidget.onChanged) {
      // progress = widget.progress;
      setState(setupPainter);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        CustomPanGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<CustomPanGestureRecognizer>(
          () {
            return CustomPanGestureRecognizer(
                onPanDown: onPanDown,
                onPanUpdate: onPanUpdate,
                onPanEnd: onPanEnd);
          },
          (instance) {},
        ),
      },
      child: CustomPaint(
        painter: painter,
      ),
    );
  }

  void setupPainter() {
    painter = _CircularKnobPainter(
        context: context,
        progressText: widget.progressText,
        progressLabelText: widget.labelText,
        progress: progress,
        knobHandleSelected: knobHandleSelected);
  }

  void onPanDown(PointerDownEvent event) {
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.globalToLocal(event.position);

    if (painter.handleBounds?.contains(position) ?? false) {
      knobHandleSelected = true;
      currentDragOffset = position;
      setState(setupPainter);
    }
  }

  void onPanUpdate(PointerMoveEvent event) {
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.globalToLocal(event.position);

    final diffInAngle = painter.calculateDiffInAngle(
      currentDragOffset,
      currentDragOffset + event.delta,
    );

    final angle =
        painter.normalizeSweepAngle(sweepAngle.subtractAngle(diffInAngle));

    if (angle > (painter.minSweepAngle) && angle < (painter.maxSweepAngle)) {
      sweepAngle = angle;
      currentDragOffset = position;
      onAngleChange();
      setState(setupPainter);
    } else {
      onPanCompleted();
    }
  }

  void onPanEnd(PointerUpEvent event) {
    onPanCompleted();
  }

  void onPanCompleted() {
    knobHandleSelected = false;
    currentDragOffset = Offset.zero;
    setState(setupPainter);
  }

  void onAngleChange() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        HapticFeedback.selectionClick();
      },
    );

    final interpolator = interpolate(
      inputMin: painter.minSweepAngle,
      inputMax: painter.maxSweepAngle,
    );

    progress = interpolator(sweepAngle);

    widget.onChanged?.call(progress);
  }
}

class _CircularKnobPainter extends CustomPainter {
  _CircularKnobPainter({
    required this.context,
    required this.progress,
    required this.progressText,
    required this.progressLabelText,
    required this.knobHandleSelected,
  }) : assert(progress >= 0 && progress <= 1.0) {
    _sweepAngle = interpolate(
        outputMin: minSweepAngle, outputMax: maxSweepAngle)(progress);
  }

  final BuildContext context;
  final double progress;

  final String progressText;
  final String progressLabelText;

  final double minSweepAngle = 0.0.radians;
  final double maxSweepAngle = 330.0.radians;

  final _startAngle = 0.0.radians;
  late double _sweepAngle = 120.radians;

  late bool knobHandleSelected = false;

  Path? knobPath;

  Size? size;

  Rect? handleBounds;

  bool? canHit(Offset offset) {
    return knobPath?.contains(offset);
  }

  @override
  bool shouldRepaint(covariant _CircularKnobPainter oldDelegate) {
    if (oldDelegate.progress != progress) {
      _sweepAngle = interpolate(
          outputMin: minSweepAngle, outputMax: maxSweepAngle)(progress);
    }

    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    this.size = size;
    final bounds = Offset.zero & size;
    final radius = size.width / 2;
    final center = bounds.center;
    final angleOffset = -90.radians;

    // Draw background
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = context.theme.colorScheme.surfaceElevation1,
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
    final knobColor = context.theme.colorScheme.primaryContainer;
    final knobHandleColor = context.theme.colorScheme.onPrimaryContainer;

    // Draw track
    canvas
      ..drawCircle(
        center,
        knobRadius,
        Paint()..color = context.theme.colorScheme.surfaceElevation3,
      )
      ..drawCircle(
        center,
        innerKnobRadius,
        Paint()..color = context.theme.colorScheme.surfaceElevation1,
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

    if (knobPath != null) {
      canvas.drawPath(
        knobPath!,
        Paint()..color = knobColor,
      );
    }

    // Draw knob handle
    final handleSize = Size.square(knobThickness);
    final handleSelectedStateColor =
        Color.lerp(knobHandleColor, knobColor, 0.5);
    handleBounds = Rect.fromCenter(
      center: Offset.lerp(endOffset, innerEndOffset, 0.5)!,
      width: handleSize.width,
      height: handleSize.height,
    );

    if (handleBounds != null) {
      canvas.drawCircle(
        handleBounds!.center,
        handleSize.radius,
        Paint()
          ..color =
              knobHandleSelected ? handleSelectedStateColor! : knobHandleColor,
      );
    }

    // Draw Progress Text
    final textColor = context.theme.colorScheme.onSurface;
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
    return toCartesian(prev, size?.radius ?? Size.zero.radius) -
        toCartesian(
          current,
          size?.radius ?? Size.zero.radius,
        );
  }
}
