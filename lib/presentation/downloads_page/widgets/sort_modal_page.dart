import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/widget/button_with_icon.dart';
import 'package:flutter/material.dart';

class SortModalPage extends StatelessWidget {
  const SortModalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(l10n.sorting, style: theme.textTheme.titleMedium),

                _sortButton(title: l10n.byDate),
                _sortButton(title: l10n.byName),
                _sortButton(title: l10n.bySize),
              ],
            ),
          ),

          Row(
            spacing: AppConstant.containerPadding,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: ButtonWithIcon(
                  label: l10n.byAscending,
                  icon: AppIcon.descSortIcon,
                ),
              ),
              Expanded(
                flex: 1,
                child: ButtonWithIcon(
                  label: l10n.byDescending,
                  icon: AppIcon.ascSortIcon,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _sortButton extends StatelessWidget {
  const _sortButton({super.key, this.title = 'Title'});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Checkbox(value: true, onChanged: (value) {}),
      ],
    );
  }
}
