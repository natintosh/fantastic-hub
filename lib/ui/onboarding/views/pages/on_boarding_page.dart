import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/app_router.gr.dart';
import 'package:hub/__core__/assets/assets.gen.dart';
import 'package:hub/__core__/extensions/build_context.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  void onGettingStartedButtonPressed() {
    context.router.navigate(const IndexRouter());
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const Gap(20),
                Assets.vectors.smartHome.svg(),
                Text(
                  localization.welcome,
                  style: context.theme.textTheme.headlineLarge,
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    localization.onBoardingMessage,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: onGettingStartedButtonPressed,
              child: Text(localization.getStarted),
            ),
          ),
          const Gap(20),
        ],
      ),
    );

    return Scaffold(
      body: content,
    );
  }
}
