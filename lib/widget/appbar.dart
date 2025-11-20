import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({super.key, required this.title , this.showLeading = false});
  final String title;
  final bool showLeading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showLeading ? IconButton(
        onPressed: () => context.pop(),
        icon: Icon(AppIcon.arrowBackIcon),
      ) : null,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
