import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/components/views/widgets/app_rounded_container.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RoutinePreview extends StatefulWidget {
  const RoutinePreview({super.key});

  @override
  State<RoutinePreview> createState() => _RoutinePreviewState();
}

class _RoutinePreviewState extends State<RoutinePreview> {
  late final PageController controller = PageController();

  final list = List.generate(5, (index) => Container());

  @override
  Widget build(BuildContext context) {
    return AppRoundedContainer(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: controller,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return list[index];
              },
            ),
          ),
          SmoothPageIndicator(
            controller: controller,
            count: list.length,
            effect: ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: context.theme.colorScheme.secondary,
              dotColor: context.theme.colorScheme.onSecondary,
            ),
          ),
          const Gap(16),
        ],
      ),
    );
  }
}
