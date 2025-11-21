import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    required this.title,
    this.showLeading = false,
    this.showActions = false,
    this.actionIcon = Icons.settings,
    this.onActionTapped,
  });
  final String title;
  final bool showLeading;
  final bool showActions;
  final IconData actionIcon;
  final void Function()? onActionTapped;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showLeading
          ? IconButton(
              onPressed: () => context.pop(),
              icon: Icon(AppIcon.arrowBackIcon),
            )
          : null,
      title: Text(title),
      actions: showActions
          ? [IconButton(onPressed: onActionTapped, icon: Icon(actionIcon))]
          : [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
