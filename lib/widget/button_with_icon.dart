import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    super.key,
    this.icon = Icons.abc,
    this.label = 'Label',
    this.color = AppColor.navBarInActiveColor,
    this.onPressed
  });
  final String label;
  final IconData icon;
  final Color color;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(color)),
      onPressed: onPressed,
      label: Text(label),
      icon: Icon(icon),
    );
  }
}
