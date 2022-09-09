import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/components/views/widgets/app_rounded_container.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/views/routines/models/data/routine.dart';
import 'package:hub/views/routines/views/widgets/routine_details.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RoutinePreview extends StatefulWidget {
  const RoutinePreview({super.key, required this.routinesStream});

  final Stream<List<Routine>> routinesStream;

  @override
  State<RoutinePreview> createState() => _RoutinePreviewState();
}

class _RoutinePreviewState extends State<RoutinePreview> {
  late final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return AppRoundedContainer(
      child: StreamBuilder<List<Routine>>(
          stream: widget.routinesStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? [];
            return Column(
              children: [
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: controller,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return RoutineDetails(
                        key: ValueKey(data[index]),
                        routine: data[index],
                      );
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: data.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: context.theme.colorScheme.secondary,
                    dotColor: context.theme.colorScheme.onSecondary,
                  ),
                ),
                const Gap(16),
              ],
            );
          }),
    );
  }
}
