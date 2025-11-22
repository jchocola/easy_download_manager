import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/widget/button_with_icon.dart';
import 'package:easy_download_manager/widget/expantion_tile.dart';
import 'package:flutter/material.dart';

class AdditionalParameter extends StatelessWidget {
  const AdditionalParameter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color: theme.colorScheme.onPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstant.containerPadding,
        children: [
          Row(
            spacing: AppConstant.containerPadding,
            children: [
              Icon(AppIcon.parameterIcon, color: theme.colorScheme.secondary),
              Text(
                l10n.additionalParameters,
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),

          Text(l10n.optionalDownloadSettings, style: theme.textTheme.bodySmall),

          ExpansionTile(
            leading: Icon(
              AppIcon.speedIcon,
              color: theme.colorScheme.secondary,
            ),
            title: Text(l10n.speedLimit),
            //  subtitle: Text('dshjshds'),
            children: [
              Row(
                children: [
                  ButtonWithIcon(label: 'Slow', icon: AppIcon.slowIcon),
                  ButtonWithIcon(label: 'Normal', icon: AppIcon.normalIcon),
                  ButtonWithIcon(label: 'Hight', icon: AppIcon.hightIcon),
                ],
              ),
            ],
          ),

          ExpansionTile(
            leading: Icon(
              AppIcon.priorityIcon,
              color: theme.colorScheme.secondary,
            ),
            title: Text(l10n.priority),
            //  subtitle: Text('dshjshds'),
            children: [],
          ),
        ],
      ),
    );
  }
}
