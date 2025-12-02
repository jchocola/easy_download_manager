import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/enum/save_place.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/main.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';
import 'package:open_file_manager/open_file_manager.dart';

class FilesPage extends StatelessWidget {
  const FilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppAppBar(title: l10n.files),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: Column(
        spacing: AppConstant.containerPadding,
        children: [
          _FileInfoCard(
            title: 'Downloads',
            icon: AppIcon.downloadIcon,
            subtitle: AppConstant.pathDefault,
            onTap: () async {
              final path = await getFullSavingPath(place: SAVE_PLACE.VIDEOS);

              logger.i(path);


              openFileManager(
                androidConfig: AndroidConfig(
                  folderType: AndroidFolderType.other,
                  folderPath: path,
                ),
              );
            },
          ),

          _FileInfoCard(
            title: 'Documents',
            icon: AppIcon.folderIcon,
            subtitle: AppConstant.pathDefault,
          ),
          _FileInfoCard(
            title: 'Videos',
            icon: AppIcon.videoIcon,
            subtitle: AppConstant.pathDefault,
          ),
          _FileInfoCard(
            title: 'Musics',
            icon: AppIcon.musicIcon,
            subtitle: AppConstant.pathDefault,
          ),
        ],
      ),
    );
  }
}

class _FileInfoCard extends StatelessWidget {
  const _FileInfoCard({
    super.key,
    this.icon = Icons.download,
    this.title = 'title',
    this.subtitle = 'subtitle',
    this.withSwitch = false,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final bool withSwitch;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: AppConstant.containerPadding/2, horizontal: AppConstant.containerPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
          color: theme.colorScheme.onPrimary,
        ),
        child: ListTile(
          leading: ContainerWithBorderColor(icon: icon, withGradient: true),
          title: Text(title, style: theme.textTheme.bodyMedium),
          subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
          trailing: Icon(
            AppIcon.arrowForwardIcon,
            size: 14,
            color: theme.colorScheme.onTertiary,
          ),
        ),
      ),
    );
  }
}
