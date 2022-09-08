import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/extensions/nums.dart';
import 'package:hub/__core__/components/styles/app_colors.dart';
import 'package:hub/__core__/components/views/widgets/app_rounded_container.dart';

class ColorPickerView extends StatefulWidget {
  const ColorPickerView({
    super.key,
    this.color = Colors.white,
    this.pickerSize = const Size(250, 250),
    this.colors = const [
      Color(0xFF63ADF2),
      Color(0xFFDB5461),
      Color(0xFF00BD9D)
    ],
    this.onChanged,
  });

  final Color color;
  final Size pickerSize;
  final List<Color> colors;
  final ValueChanged<Color>? onChanged;

  @override
  State<ColorPickerView> createState() => _ColorPickerViewState();
}

class _ColorPickerViewState extends State<ColorPickerView> {
  @override
  void initState() {
    selectedColor = widget.color;
    colorHighlight = widget.colors.first;
    super.initState();
  }

  late Color selectedColor;

  late Color colorHighlight;

  void onColorHighlightTap(Color color) {
    setState(() {
      colorHighlight = color;
    });
  }

  void onChange(Color color) {
    widget.onChanged?.call(color);
    setState(() {
      selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox.fromSize(
          size: widget.pickerSize,
          child: ColorPickerWidget(
            color: colorHighlight,
            onChanged: onChange,
          ),
        ),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (final color in widget.colors)
              DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: color != colorHighlight
                        ? null
                        : Border.all(
                            width: 2,
                            color: context.theme.colorScheme.primary,
                          )),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AppRoundedContainer(
                    color: color,
                    child: Material(
                      color: AppColors.transparent,
                      child: InkWell(
                        onTap: () => onColorHighlightTap(color),
                        child: const SizedBox(width: 54, height: 24),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        )
      ],
    );
  }
}

class ColorPickerWidget extends LeafRenderObjectWidget {
  const ColorPickerWidget({
    super.key,
    this.onChanged,
    this.color = const Color(0xff0c82df),
  });

  final ValueChanged<Color>? onChanged;
  final Color color;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _ColorPickerRenderBox(color: color, onChanged: onChanged);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _ColorPickerRenderBox renderObject) {
    renderObject.onUpdateRenderObject(color: color, onChanged: onChanged);
  }
}

class _ColorPickerRenderBox extends RenderBox {
  _ColorPickerRenderBox(
      {required Color color, required ValueChanged<Color>? onChanged}) {
    _color = color;
    _onChanged = onChanged;
    sweepGradient = LinearGradient(
      colors: [
        const Color(0xffffffff),
        color,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    tap = TapGestureRecognizer()
      ..onTapDown = onTapDown
      ..onTapUp = onTapUp;
  }

  ValueChanged<Color>? _onChanged;

  late Color _color;

  late TapGestureRecognizer tap;

  late LinearGradient sweepGradient;

  late RRect circleBounds;

  late Offset currentOffset = Offset.zero;

  late bool showSelector = false;

  final Size selectorSize = const Size(16, 16);

  void onUpdateRenderObject({Color? color, ValueChanged<Color>? onChanged}) {
    _color = color ?? _color;
    _onChanged = onChanged ?? _onChanged;
    sweepGradient = LinearGradient(
      colors: [
        const Color(0xffffffff),
        _color,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    markNeedsPaint();
  }

  @override
  bool hitTestSelf(Offset position) {
    return circleBounds.contains(position);
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    if (event is PointerDownEvent) {
      tap.addPointer(event);
    }
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = constraints.maxWidth;
    final desiredSized = Size.square(min(desiredWidth, desiredHeight));
    return constraints.constrain(desiredSized);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    final bounds = offset & size;
    final radius = size.width / 2;

    circleBounds = RRect.fromRectAndRadius(bounds, const Radius.circular(16));

    // Draw circle with gradient color
    canvas.drawRRect(
      circleBounds,
      Paint()..shader = sweepGradient.createShader(bounds),
    );

    // Draw color selector
    final Rect selectorBound = (currentOffset -
            Offset(selectorSize.width / 2, selectorSize.height / 2)) &
        selectorSize;

    final path = Path()
      ..moveTo(currentOffset.dx - selectorSize.width,
          currentOffset.dy - selectorSize.height)
      ..arcTo(
        selectorBound,
        0.radians,
        359.radians,
        true,
      );

    if (showSelector) {
      canvas.drawPath(
        path,
        Paint()
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..color = Colors.white,
      );
    }
  }

  void onTapDown(TapDownDetails details) {
    showSelector = true;
    markNeedsPaint();
  }

  void onTapUp(TapUpDetails details) {
    currentOffset = details.localPosition;

    _onChanged?.call(resolveColorFromOffset(currentOffset));

    markNeedsPaint();
  }

  Color resolveColorFromOffset(Offset offset) {
    return Color.lerp(
      Colors.white,
      _color,
      getSelectedPercentageFromOffset(offset),
    )!;
  }

  double getSelectedPercentageFromOffset(Offset offset) {
    final maxDisplacement =
        sqrt(pow(size.longestSide, 2) + pow(size.shortestSide, 2));
    final displacement = sqrt(pow(offset.dx, 2) + pow(offset.dy, 2));

    return displacement / maxDisplacement;
  }
}
