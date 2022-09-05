import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/assets/assets.gen.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/views/ui/widgets/app_rounded_container.dart';
import 'package:lorem_gen/lorem_gen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsPreview extends StatefulWidget {
  const NewsPreview({super.key});

  @override
  State<NewsPreview> createState() => _NewsPreviewState();
}

class _NewsPreviewState extends State<NewsPreview> {
  late final PageController controller = PageController();

  final list = List.generate(5, (index) => const NewsDetails());

  @override
  Widget build(BuildContext context) {
    return AppRoundedContainer(
      child: Column(
        children: [
          SizedBox(
            height: 132,
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

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppRoundedContainer(
            child: SizedBox.square(
              dimension: 100,
              child: Assets.images.mockNewsImage.image(fit: BoxFit.cover),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Lorem.word(numWords: 4),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.titleMedium,
                ),
                const Gap(8),
                Text(
                  Lorem.text(numParagraphs: 1, numSentences: 3),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.bodySmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
