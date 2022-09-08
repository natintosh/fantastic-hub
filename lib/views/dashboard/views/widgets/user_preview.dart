import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/assets/assets.gen.dart';
import 'package:hub/__core__/extensions/build_context.dart';

class UserPreview extends StatelessWidget {
  const UserPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization.welcomeUser('Michael'),
                style: context.theme.textTheme.titleLarge,
              ),
              const Gap(4),
              Text(
                localization.letsManageYourSmartHome,
                style: context.theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        SizedBox.square(
          dimension: 56,
          child: ClipOval(
            child: Assets.images.mockProfileImage.image(
              fit: BoxFit.cover
            ),
          ),
        )
      ],
    );
  }
}
