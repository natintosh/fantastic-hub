import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hub/__core__/extensions/build_context.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.padding,
    this.onClick,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enableSuggestions = false,
    this.enableInteractiveSelection = true,
    this.autocorrect = false,
    this.isPassword,
    this.isDense = false,
    this.readOnly = false,
    this.showCursor = true,
    this.textStyle,
    this.hintTextStyle,
    this.fontWeight,
    this.fontSize,
    this.inputFormatters,
    this.maxLength,
    this.borderRadius = 8,
  });

  const factory AppTextField.text({
    Key? key,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    String? hintText,
    String? initialValue,
    double borderRadius,
    EdgeInsets? padding,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    List<TextInputFormatter> inputFormatters,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    bool showCursor,
    bool readOnly,
    int? maxLength,
  }) = _AppStatefulTextField;

  const factory AppTextField.time({
    Key? key,
    required BuildContext context,
    TextEditingController? controller,
    ValueChanged<TimeOfDay>? onTimeSet,
    ValueChanged<String>? onChanged,
    String? hintText,
    DateTime? startDate,
    String dateFormat,
  }) = _AppTextFieldTimePicker;

  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final EdgeInsets? padding;
  final VoidCallback? onClick;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enableSuggestions;
  final bool enableInteractiveSelection;
  final bool autocorrect;
  final bool? isPassword;
  final bool isDense;
  final bool readOnly;
  final bool showCursor;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final FontWeight? fontWeight;
  final double? fontSize;
  final List<TextInputFormatter>? inputFormatters;
  final double borderRadius;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return textField(
      context: context,
      inputDecoration: decoration(context: context),
    );
  }

  Widget textField({
    required BuildContext context,
    required InputDecoration inputDecoration,
    TextEditingController? controller,
  }) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller ?? this.controller,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      decoration: inputDecoration,
      showCursor: showCursor,
      readOnly: readOnly,
      maxLength: maxLength,
      onTap: onClick,
      enableInteractiveSelection: enableInteractiveSelection,
      style: textStyle,
    );
  }

  InputDecoration decoration(
      {required BuildContext context, String? errorText}) {
    return InputDecoration(
      isDense: isDense,
      filled: true,
      fillColor: context.theme.colorScheme.surfaceVariant,
      contentPadding: padding,
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
    );
  }
}

class _AppStatefulTextField extends AppTextField {
  const _AppStatefulTextField({
    super.key,
    super.onChanged,
    super.controller,
    super.hintText,
    super.initialValue,
    super.borderRadius,
    super.padding,
    super.keyboardType = TextInputType.text,
    super.textInputAction,
    super.inputFormatters,
    super.textStyle,
    super.hintTextStyle,
    super.showCursor,
    super.readOnly = false,
    super.maxLength,
  });

  @override
  Widget textField({
    required BuildContext context,
    required InputDecoration inputDecoration,
    TextEditingController? controller,
  }) {
    return super.textField(
      context: context,
      inputDecoration: decoration(context: context),
      controller: super.controller,
    );
  }
}

class _AppTextFieldTimePicker extends AppTextField {
  const _AppTextFieldTimePicker({
    super.key,
    required this.context,
    super.controller,
    this.onTimeSet,
    super.onChanged,
    super.hintText,
    this.startDate,
    this.dateFormat = 'yyyy/MM/dd',
  }) : super(
          showCursor: false,
          readOnly: true,
          enableInteractiveSelection: false,
          keyboardType: TextInputType.none,
        );

  final ValueChanged<TimeOfDay>? onTimeSet;
  final BuildContext context;
  final DateTime? startDate;
  final String dateFormat;

  @override
  VoidCallback? get onClick => _displayDatePicker;

  Future<void> _displayDatePicker() async {
    final time = await showTimePicker(
      context: context,
      helpText: '',
      cancelText: 'Close',
      confirmText: 'Done',
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      _onDateTimeChange(time);
    }
  }

  String _getFormattedDate(TimeOfDay time) {
    return time.format(context);
  }

  void _onDateTimeChange(TimeOfDay time) {
    final formattedDate = _getFormattedDate(time);

    controller?.text = formattedDate;
    onChanged?.call(formattedDate);

    onTimeSet?.call(time);
  }
}
