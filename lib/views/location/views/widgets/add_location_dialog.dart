import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/extensions/build_context.dart';
import 'package:hub/__core__/components/styles/app_colors.dart';
import 'package:hub/__core__/components/views/widgets/app_text_field.dart';

class AddLocationDialog extends StatefulWidget {
  const AddLocationDialog({super.key});

  static Future<void> showDialog(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.transparent,
      builder: (context) {
        return const AddLocationDialog();
      },
    );
  }

  @override
  State<AddLocationDialog> createState() => _AddLocationDialogState();
}

class _AddLocationDialogState extends State<AddLocationDialog> {
  void onAddLocationButtonPressed() {}

  @override
  Widget build(BuildContext context) {
    final content = ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      children: [
        const Gap(20),
        AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Add Location'),
        ),
        const Gap(20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'LOCATION NAME',
            style: context.theme.textTheme.bodySmall,
          ),
        ),
        const Gap(8),
        const AppTextField.stream(valueStream: Stream.empty()),
        const Gap(20),
        SizedBox(height: context.mq.viewInsets.bottom),
        ElevatedButton(
          onPressed: onAddLocationButtonPressed,
          child: const Text('Add Location'),
        ),
        const Gap(50),
      ],
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: content,
    );
  }
}
