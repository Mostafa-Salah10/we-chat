import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.isSecure = false,
    this.onTapSuffixIcon,
    this.keyboardType,
    this.initialValue,
    this.onSaved,
  });

  final String label;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final bool isSecure;
  final void Function()? onTapSuffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      cursorColor: AppColors.lightGrey,
      obscureText: isSecure,
      validator: _validateInput,
      onSaved: onSaved,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        suffixIcon:
            suffixIcon == null
                ? null
                : GestureDetector(onTap: onTapSuffixIcon, child: suffixIcon),
      ),
    );
  }

  String? _validateInput(value) {
    if (value!.isEmpty) {
      return AppStrings.fieldRequired;
    } else if (value.length < 6) {
      return AppStrings.fieldShort;
    } else {
      return null;
    }
  }
}
