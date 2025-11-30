import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.hintText = 'Hint text',
    this.onChanged,
    this.controller,
    this.readOnly = false
  });
  final String hintText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      onChanged: onChanged,
      readOnly: readOnly,
      cursorColor: theme.focusColor,
      style: theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.textTheme.bodySmall,
        
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.unselectedWidgetColor),
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.focusColor),
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        ),
      ),
    );
  }
}
